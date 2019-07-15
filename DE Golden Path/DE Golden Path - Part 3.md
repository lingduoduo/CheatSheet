All this is known as **orchestration**.

This tutorial shows you how to orchestrate your Scio pipeline using **Luigi**, an open-source python orchestration framework originally built at Spotify. The **Hades** service is used to reliably signal whether a dataset partition is complete.

For more information about Luigi, see [A crash course in Luigi] and [this introduction]. 

For more information on Hades, see [What is Hades and how does it help].

Important!

This tutorial addresses orchestration (coordination) of pipelines, not scheduling. It deals with dependencies, but invoking a new run is explained in [Part 4].

### Prerequisite

In this tutorial, your work depends on a lot of Python libraries. You do not want to install them directly on your work machine, since the next part talks about how to package all these libraries and your pipeline in a single docker image.

Run the following commands in the root directory of the `di-golden-path-pipeline` project that you created in [part 2]in order to establish a Python virtual environment and install all related Python libraries in it. You also need to [configure IntelliJ]to use the vir tualenv if you use IntelliJ to develop Python code.

Note

Your pipeline runtime in production remains python2, so make sure that you use python2 to create the virtualenv.

```
$ sudo pip install virtualenv
$ virtualenv part3
$ source part3/bin/activate
$ pip install luigi
$ pip install -r requirements.txt
$ echo "part3/" >> .gitignore # ignore the virtualenv folder
```

After completing this tutorial, you will exit the virtual environment.

### Orchestrate your Scio pipeline from part 2

In [part 2] of the Data Engineering Golden Path, you created a Scio pipeline to compute the top N artists for a specific day based on the EndContentFactXT data. Here, you are going to orchestrate it with Luigi.

Adjust the pipeline code

Previously, your pipeline has depended on a fixed partition of TrackEntity to uncover the artist/track relationships. It may be a problem if you want to run your pipeline every day because there might be a new track that puts an artist at the top of your list, but this artist/track relationship might not get captured in the old partition of TrackEntity that you depend on. You must change it to ensure that you have all artist/track relationships when you process the EndContentFactXT data, that is, use the partition of TrackEntity data that matches the day of the EndContentFactXT data you are processing.

Open your pipeline Scala code in: `di-golden-path-pipeline/src/main/scala/com/spotify/data/example/TopArtistsJob.scala`

```
@BigQueryType.fromQuery(
 """
   |SELECT
   |  track_gid,
   |  artist.artist.gid AS artist_gid,
   |  artist.artist.name AS artist_name
   |FROM `%s.%s.%s`,
   |     UNNEST(master_metadata.artist) AS artist
   |WHERE track_gid is not null
   |  AND artist.artist.gid is not null
   |  AND artist.artist.name is not null
 """.stripMargin, "scio-playground", "di_golden_path", "track_entity_20181031")
class TrackEntity
```

Here, pass the tableSpecs information when you query for the TrackEntity data. As before, use a fixed table to generate the case class. However, you make it possible here to pass in other tableSpecs when you perform the query.

```
import com.spotify.scio.values.SCollection
…

val trackEntityTableRef = BigQueryHelpers.parseTableSpec(args("trackEntity"))

val trackEntities: SCollection[TrackEntity] = sc.typedBigQuery[TrackEntity](
 TrackEntity.query.format(
   trackEntityTableRef.getProjectId,
   trackEntityTableRef.getDatasetId,
   trackEntityTableRef.getTableId
 )
)
```

Add a new Scio argument, trackEntity, to make it possible to pass the tableSpecs from the command line. You know that your arguments will be passed by ScioJobTask, as displayed in the previous exercises, so a tableSpecs with legacy syntax will be passed.

The query in your pipeline is in standard syntax. Therefore, parse the tableSpecs with legacy syntax to a TableReference object using the helper method in BigQueryHelpers, and then extract the project, dataset and table information to pass into your query. In order to use this helper method, add the following import statement.

```
import org.apache.beam.sdk.io.gcp.bigquery.BigQueryHelpers
```

### Create the corresponding Luigi tasks

You can now create your related Luigi tasks in `di-golden-path-pipeline/src/main/python/top_artists.py`.

Import all the necessary classes:

```
import luigi
from spotify_scala_luigi.scio import ScioJobTask
from spotify_hades import LookupDaily, HadesTarget
from luigi.contrib.bigquery import BigQueryTarget
```

Define a TrackEntity external task that represents your TrackEntity table with a specific date.

Do not confuse this with the TrackEntity class in your Scala code. That one represents a track plus an entity. This one encapsulates the procedure for selecting the BigQuery table of Tracks+Entities for a given date.

```
class TrackEntity(luigi.ExternalTask):
    date = luigi.DateParameter()

    def output(self):
        return BigQueryTarget(
            project_id='scio-playground',
            dataset_id='di_golden_path',
            table_id='track_entity_%s' % self.date.strftime('%Y%m%d')
        )
```

Define the basic structure of your TopArtistsJob task which is a subclass of ScioJobTask.

```
class TopArtistsJob(ScioJobTask):
    date = luigi.DateParameter()
    top_n = luigi.IntParameter()
    endpoint = luigi.Parameter(default='di.golden.path.<username>.top_artists')
    uri_prefix = luigi.Parameter(default='gs://scio-playground/di_golden_path/part3/<username>/', significant=False)
    package = 'com.spotify.data.example'
    project = 'scio-playground'
    region = 'europe-west1'
    autoscaling_algorithm = 'THROUGHPUT_BASED'
    max_num_workers = 25
    staging_location = 'gs://scio-playground/user/<username>/dataflow/staging'
    temp_location = 'gs://scio-playground/user/<username>/dataflow/tmp'
    beam = True
```

It contains all Python variables related to cloud dataflow options. It also has two Luigi parameters: date and top_n. As discussed before, you want to generate your top artists list per day, as indicated by the date parameter. You also ask the user to pass in the number of topmost artists you want to keep by setting the top_n parameter.

Note

When you run this task from the command line, use --top-n instead of --top_n as the argument key for top_n. In fact, Luigi uses underscores to replace hyphens for all hyphenated Luigi parameters in the command line. A command line example is shown in the next section.

Add the following method to TopArtistsJob class:

```
def args(self):
    return [
        '--topN=%d' % self.top_n
    ]
```

Now that you have the basic structure of your task, pass the number of artists you want to keep in your result from the Luigi parameter to DataFlow by overriding the args method in the task. As discussed before, it gets appended in the execution command for submitting your pipeline. It corresponds to this line of Scala code in your pipeline’s main method.

```
val topN = args("topN").toInt
```

Note

The writing convention for Scio arguments is camelCase, instead of hyphenated (kebab-case) or with underscore (snake_case).

Add the following method to TopArtistsJob class:

```
def requires(self):
    return {
        'endContentFact': LookupDaily(
            endpoint='di.golden.path.EndContentFactXT2',
            partition=self.date
        ),
        'trackEntity': TrackEntity(date=self.date)
    }
```

You declare two dependencies as a dictionary in the requires method. The requires method tells Luigi that the Scio job should only be run when all of the dependencies exist. Because the keys of the dictionary are used to construct the Scio command line, they need to match argument names in your job code.

For the endContentFact data, use the LookupDaily Hades external task. ScioJobTask will append `--endContentFact=<storage uri for this partition of endContentFact>` on the command line.

For the trackEntity data, you depend on the external task you just defined above. ScioJobTask will append `--trackEntity=<tableSpecs in legacy syntax>` on the command line.

Add the following method to `TopArtistsJob` class:

```
def output(self):
    return {
        'textOutput': HadesTarget(
            endpoint=self.endpoint,
            partition=self.date.strftime("%Y-%m-%d"),
            uri_prefix=self.uri_prefix
        ),
        'bqOutput': BigQueryTarget(
            project_id='scio-playground',
            dataset_id='<username>',
            table_id='top_artists_daily%s' % self.date.strftime('%Y%m%d')
        )
    }
```

Finally, define the output targets in your task. Since you want to output to two locations in your pipeline, you return a dictionary of two elements whose keys correspond to the following two lines of code.

```
val textOutput = args("textOutput")
val bqOutput = args("bqOutput")
```

For the text output, put the result in GCS and therefore you need to use a HadesTarget here. Hades enables you to publish an unregistered data endpoint for testing purposes. Therefore, you can publish to the endpoint with your user id in it.

For the BigQuery output, use a BigQueryTarget here. As discussed before, your task will first pass a tableSpecs representing a temporary table in the same project, and then atomically copy the data from the temporary table to the actual table.

###  Unit test your Luigi code

Make sure you are in **virtualenv part3**, created and activated earlier (see [Prerequisite]. And then:

```
pip install tox
tox
```

This runs a style check against your Luigi code, runs unit tests, and generates a coverage report.

Alternatively, you can use [tox action-container] without needing to install tox into your virtualenv.

```
docker run --rm -i -w $(pwd) -v $(pwd):$(pwd) gcr.io/action-containers/tox:3.5.2-2 -c tox.ini
```

Note that both of the above alternatives should be run in the root of the repository.

### Run your pipeline with Luigi

Make sure you are in **virtualenv part3**, created and activated earlier (see [Prerequisite].

Since you have changed your pipeline code, it’s time to repackage your pipeline by running the following in the project root directory:

```
sbt compile pack
```

Then, run the following command to invoke your pipeline.

```
$ PYTHONPATH='di-golden-path-pipeline-<username>/src/main/python/' JAR_DIR='di-golden-path-pipeline-<username>/target/pack/lib' luigi --module top_artists TopArtistsJob --date 2018-10-31
 --top-n 100 --local-scheduler
```

Here is the execution command in the logs:

```
INFO: java -Xmx256m -cp di-golden-path-pipeline-<username>/target/pack/lib/di-golden-path-pipeline-<username>_2.11-0.1.0-SNAPSHOT.jar com.spotify.data.example.TopArtistsJob --runner=DataflowRunner --project=scio-playground --region=europe-west1 --stagingLocation=gs://scio-playground/user/<username>/dataflow/staging --tempLocation=gs://scio-playground/user/<username>/dataflow/tmp --autoscalingAlgorithm=THROUGHPUT_BASED --maxNumWorkers=25 --blocking --trackEntity=scio-playground:di_golden_path.track_entity_20181031 --endContentFact=gs://golden-path-sample-data/di.golden.path.EndContentFactXT2/2018-10-31/20181031T075406.854146-12dc225803c3
/*.avro 
--bqOutput=scio-playground:_incoming_EU._top_artists_daily20181031_2295469999 --textOutput=gs://scio-playground/di_golden_path/part3/<username>/<random location> --topN=100
```

For the text output location, you have passed a random URI since you use HadesTarget. The URI will get published to the Hades backend service if your pipeline finished successfully.

For the BigQuery output tableSpecs, it is a temporary table in the same project. You move the data to the actual table in an atomic fashion in your task. The moving of the table occurs after the pipeline is finished successfully in the log.

```
INFO: Moving temporary table BQTable(project_id='scio-playground', dataset_id='_incoming_EU', table_id='_top_artists_daily_20170227_6810145578', location=None) to final table BQTable(project_id='scio-playground', dataset_id=<username>, table_id='top_artists_daily_20170227', location=None)
```

The following illustration shows your orchestrated pipeline running in the cloud:

Finally, let’s check if the text output location is actually published in Hades by using the [hades-cli](https://confluence.spotify.net/display/HAD/Hades+CLI) tool in the command line.

```
$ hades ls di.golden.path.lingh.top_artists 2018-10-31
> REVISIONS
REVISION_ID                            CREATION_TIME               URI
7d4705f9-a141-4fd0-a32d-91d00f1ff6ad   2017-03-21T14:47:27.957Z    gs://scio-playground/di_golden_path/part3/lingh/di.golden.path.lingh.top_artists/2018-10-31/<random path>
```

You published one revision to Hades for your data endpoint as expected. You can see who is the top artist on that date in BigQuery by using the listed URI to print the text output file: `gsutil cat <URI>/part`.

Final tasks
Exit from the virtual environment by running the following command in the project root directory.

```
$ deactivate && rm -r part3/
```