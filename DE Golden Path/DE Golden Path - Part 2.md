Part 2

**Introduction**

In this part of the Data Engineering Golden Path you will learn how to build a data pipeline using the Scio skeleton, launch it on Google Cloud Dataflow, and inspect the output. You will learn how to answer the question:

**Who were the top 10 most streamed artists yesterday, and how many streams did they get?**

You will create **a data pipeline**. A data pipeline is a collection of data processing job definitions, also called workflow definitions, that live together in the same GHE repository. Later we will see how individual workflows get built and scheduled.

We will introduce you to [Scio](https://github.com/spotify/scio), then you will execute your pipeline in a playground environment. (In practice, running a pipeline in production requires several more steps, such as setting up a Google project, access control, scheduling your data pipeline, etc. We will skip over these topics for now but we will cover them in the following tutorials.)

General support with this Golden Path is offered on the [#data-support](https://spotify.slack.com/messages/C047H3XMT/) channel in Slack and through the keyword [data](https://spotify.stackenterprise.co/questions/tagged/data) on Stack Enterprise.

**Understanding basic Scio concepts**

At Spotify, Scio is the preferred solution to develop batch and streaming data pipelines with [Apache Beam](https://github.com/apache/beam) and run them on [Google Cloud Dataflow](https://cloud.google.com/dataflow/). Please have a look at [Scio’s README](https://github.com/spotify/scio/blob/master/README.md) for a general introduction.

Note

This part of the Golden Path focuses only on batch processing. You will learn about real-time streaming later in a later section.

**Scio’s documentation**

Scio is an open-source project; its source code is hosted on a [public repository on GitHub](https://github.com/spotify/scio). Its documentation lives on a [GitHub wiki](https://spotify.github.io/scio/). You can also find the scaladoc [here](http://spotify.github.io/scio/api/com/spotify/scio/index.html) and batch and streaming jobs examples on [this page](http://spotify.github.io/scio/examples/).

### What is an SCollection?[¶](https://backstage.spotify.net/docs/data-engineering-golden-path/part-2-creating-and-running-a-data-pipeline/2-understanding-scios-basic-concepts/#what-is-an-scollection)

Before getting into the code, you need to understand what an SCollection is. It is the key abstraction of a dataset in Scio. **An SCollection is an "immutable, partitioned collection of elements that can be operated on in parallel"**. Scio’s SCollection wraps Beam’s [PCollection](https://beam.apache.org/documentation/programming-guide/#pcollections).

### What is a ScioContext?[¶](https://backstage.spotify.net/docs/data-engineering-golden-path/part-2-creating-and-running-a-data-pipeline/2-understanding-scios-basic-concepts/#what-is-a-sciocontext)

The **ScioContext** is the main entry point for Scio functionality. Scio’s ScioContext wraps Beam’s [Pipeline](https://beam.apache.org/documentation/programming-guide/#creating-a-pipeline).

Have a look at [this page of the wiki for more explanations of Scio’s concepts and how they map to Beam](https://spotify.github.io/scio/Scio,-Beam-and-Dataflow).

### Understanding a simple Scio job[¶](https://backstage.spotify.net/docs/data-engineering-golden-path/part-2-creating-and-running-a-data-pipeline/2-understanding-scios-basic-concepts/#understanding-a-simple-scio-job)

Before creating your own pipeline, have a look at one of Scio examples: Scio’s [WordCount](http://spotify.github.io/scio/examples/WordCount.scala.html). Make sure you understand how wordcount works **before going any further**. Make sure you understand the role of ContextAndArgs, how Scio reads arguments from the command line (see input and output), and how [ScioMetrics](https://spotify.github.io/scio/api/com/spotify/scio/ScioMetrics$.html) is used.

**Creating a GHE repository for your pipeline using Backstage**

> We will start by creating a new GHE repository for your data pipeline using a Backstage template. It includes all related components so you don’t need to start from scratch.

1. Go to [Backstage](https://backstage.spotify.net/) and click the **+ Create** button in the toolbar.
2. Select **New Component**
3. Select the **Styx Scheduled Scio Pipeline** template.
4. Fill out the form as follows:
5. **Project Name/Component Id**: Must be unique. We suggest `di-golden-path-pipeline-<username>`, so others can see that it is yours.
6. **Description**: A brief description of the pipeline.
7. **Owner**: your `<username>`
8. **Repository location**: `ghe.spotify.net/<username>`
9. **GCP Project**: `scio-playground`
10. **Deploy to Styx Service Account key GCS bucket** ([GCS bucket containing key of the service account used to deploy to Styx](https://backstage.spotify.net/docs/tingle/secrets/)): `Scio-playground` Note that the actual secrets setup for productionized workflows will be covered in Part 4; for local development purposes, it doesn’t matter.
11. Click **Finish** to review the form values.
12. Click **CREATE COMPONENT** to create a new repository in GHE.

After submitting the form, you should see a success notification. Your newly created Git repository should be at `https://ghe.spotify.net/<username>/di-golden-path-pipeline-<username>`

You should also be able to search and find your pipeline in Backstage after registering it. It may take a minute for the pipeline to show up in Backstage.

It is time to clone your newly created repository to your laptop:

```
$ git clone git@ghe.spotify.net:<username>/di-golden-path-pipeline-<username>.git
```

**Understanding what’s inside the new repository, cloning it and opening it in IntelliJ**

![The repository structure](https://backstage-proxy.spotify.net/api/docproxy/data-engineering-golden-path/part-2-creating-and-running-a-data-pipeline/img/image_2.png)

The newly created repository contains many files. Several are unrelated to this part and will be dealt with bit by bit in the following parts.

The template provides you with one example data pipeline within the repository. However, it is common that a repository contains more than one data pipeline. Let’s take a look at the structure before you move on.

In the description of the repository structure below, the term **data endpoint** is used several times. This concept will be discussed further throughout the Golden Path, but in the meantime you can find a formal definition in the [DI Glossary](https://confluence.spotify.net/display/DI/Concepts+and+Terminology#ConceptsandTerminology-Metadata/UI).

For now, assume that a data endpoint is a representation of the output of a scheduled data pipeline. It can be partitioned by hours, days, weeks or months depending on how frequently your pipeline is configured to run. Each partition contains data for that time period. The data can be stored in different formats: Avro, Protocol Buffers, BigQuery, BigTable, and so on.

Note

In this tutorial, we focus mainly on writing Avro files to GCS and saving to BigQuery, because these are two of the most common internal use cases. GCS data can be easily and cheaply consumed by downstream pipelines, while BQ is commonly used for ad-hoc analytics. However, if your data is needed in a high-QPS, low-latency backend service, you may want to output to [Google Cloud Bigtable](https://cloud.google.com/bigtable/). You can find a Scio example [here](https://github.com/spotify/scio/blob/master/scio-examples/src/main/scala/com/spotify/scio/examples/extra/BigtableExample.scala).

| Path                                                  | Description                                                  |
| :---------------------------------------------------- | :----------------------------------------------------------- |
| `di-golden-path-pipeline-<username>-schemas/src/main` | If your pipeline outputs data in the Avro or Protobuf formats, you must describe those schemas and store them here.This is an SBT subproject. In other words, when you build the parent project, all the schemas in this directory are also compiled and included. |
| `di-golden-path-pipeline-<username>/src`              | This is where most of your pipeline code logic resides. Within `src`, there is a main subdirectory that stores pipeline logic and a test subdirectory that stores tests. Within the main directory, there are `python` and `scala` subdirectories. The Python code is mostly related to orchestration of your pipeline, which gets described in later parts. This part deals mostly with the Scala subdirectory. This is also an SBT subproject. When the parent project is built, all code in this directory also gets included. |
| `build.sbt`                                           | This file instructs SBT how to build your project: what version of Scala to use, which libraries to include (including Scio), how to compile the code, how to build a Docker image of the project, etc. Don’t edit it right now, unless you have to add a new library to your dependencies. |
| `data-info.yaml`                                      | This file documents the required information for registering your pipeline in [Backstage](https://backstage.spotify.net/): who owns the project, what the component ID is, etc. Some of this information was entered automatically when you created the repository. Here you also document the data endpoint(s). Complete documentation about this file is found on the [Define Schema in Sysmodel](https://confluence.spotify.net/display/DI/Define+Schema+in+Sysmodel) page under [Define your workflow in data-info.yaml](https://confluence.spotify.net/display/DI/Define+Schema+in+Sysmodel#DefineSchemainSysmodel-Defineyourworkflowindata-info.yaml). |
| `requirements.txt`                                    | This file specifies what additional Python packages you need for your data pipeline(s) in this project. Normally, packages added here are related to the orchestration or monitoring of your pipeline, which will be discussed in later parts. |

Now set up and index the project in IntelliJ:

1. In IntelliJ IDEA, click **Open**.
2. Navigate to the directory that you have just created, `di-golden-path-pipeline-<username>`.
3. Click **OK**. The **Import Project from sbt** dialog appears.
4. Click **OK**. IntelliJ indexes and sets up your project. Typically, this takes about five minutes.

**Understanding the example from the template**

> A good starting point to learn how to use Scio is by understanding the example pipeline job from the template.

### Deep dive into the example project[¶](https://backstage.spotify.net/docs/data-engineering-golden-path/part-2-creating-and-running-a-data-pipeline/4-understanding-whats-inside-the-new-repository/#deep-dive-into-the-example-project)

We will now go through the example code in `di-golden-path-pipeline-<username>/src/main/scala/com/spotify/data/example/BrownieRecsJob.scala`, line-by-line.

`BrownieRecsJob` finds the top N tracks played by each user and saves them to a CSV file.

```
val pipe = sc.avroFile[EndContentFactXT](input)
```

Here, you use the ScioContext **sc** to read an Avro dataset (may contain multiple Avro files) into an SCollection from GCS.

Normally, you need to set up permissions correctly in order to read/write data from/to a GCS bucket. However, in the playground environment for this part, it has been set up for you. Permissions in the GCP world is an important topic that is revisited in later parts.

At Spotify, you normally only read/write Avro [SpecificRecord](https://avro.apache.org/docs/1.7.7/api/java/org/apache/avro/specific/SpecificRecord.html). For `SpecificRecord`, you need to specify a class generated from the Avro schema used by your input file as type parameter `T`, to instruct Scio how to deserialize the data. In your case, `T` is `EndContentFactXT`.

Many common Avro schemas (`.avsc` files) at Spotify reside in the [datainfra/schemas](https://ghe.spotify.net/datainfra/schemas) repository where they are used to generate Java classes, and the resulting `.jar` package is published to Spotify’s [artifactory](https://artifactory.spotify.net/artifactory/webapp/#/artifacts/browse/tree/General/libs-snapshot-local/com/spotify/data/spotify-data-schemas) [r](https://artifactory.spotify.net/artifactory/webapp/#/artifacts/browse/tree/General/libs-snapshot-local/com/spotify/data/spotify-data-schemas)e[p](https://artifactory.spotify.net/artifactory/webapp/#/artifacts/browse/tree/General/libs-snapshot-local/com/spotify/data/spotify-data-schemas)o[s](https://artifactory.spotify.net/artifactory/webapp/#/artifacts/browse/tree/General/libs-snapshot-local/com/spotify/data/spotify-data-schemas)i[t](https://artifactory.spotify.net/artifactory/webapp/#/artifacts/browse/tree/General/libs-snapshot-local/com/spotify/data/spotify-data-schemas)o[r](https://artifactory.spotify.net/artifactory/webapp/#/artifacts/browse/tree/General/libs-snapshot-local/com/spotify/data/spotify-data-schemas)y. In this case though, the `EndContentFactXT` schema resides in [core-data-pipelines-schemas](https://ghe.spotify.net/core-data/core-data-pipelines/tree/master/core-data-pipelines-schemas), so we add it as a project dependency (in `build.sbt`). This allows us to use the `EndContentFactXT` class which was generated from [EndContentFactXT2.avsc](https://ghe.spotify.net/core-data/core-data-pipelines/blob/master/core-data-pipelines-schemas/src/main/avro/EndContentFactXT2.avsc). Schemas will be further explained in a later part about data discovery.

**Each step of computation is fully explained in the project comments. Make sure you understand everything it’s doing. You will need it in the next sections of this tutorial.**

To be able to use **saveAsTextFile** to save the `SCollection` to text files in GCS, you need to **make sure that you have the correct permissions**. For this particular project, your permission should have already been set up in the playground environment.

In this job, we save each `SCollection` element – String values, in this case – to a plaintext file, separated by newlines. **textFile** sinks are mostly useful for development to check that your output looks right. However, you will rarely do this in production.

**Closing the ScioContex**

```
sc.close().waitUntilDone()
```

The last step is to close the `ScioContext` with `sc.close()`. If you forget to close the context, your job won’t run.

The main program submits the job with `sc.close()`, and then the main program and the data pipeline run independently. In this example we invoke `waitUntilDone()` to make the main program wait for the pipeline to finish; this is common when orchestrating with Luigi and Airflow. (Without the `waitUntilDone()`, the main program would terminate immediately, though the data pipeline would keep running. Keep this in mind when debugging.)

**Running the example and submitting it to Google Cloud Dataflow**

You’ve walked through the job, now it’s time to run it. You do this using **sbt** to submit the job to Google’s Cloud Dataflow runner.

Note

If at this point this run fails with `[error] java.lang.RuntimeException: Nonzero exit code returned from runner: 1` check out the following section on access control.

In the project root directory, run the following commands to open the **sbt** console and run your pipeline in Google Cloud Dataflow:

```
$ sbt
> project di-golden-path-pipeline-<username>
> runMain com.spotify.data.example.BrownieRecsJob --input=gs://golden-path-sample-data/di.golden.path.EndContentFactXT2/2018-10-31/20181031T075406.854146-12dc225803c3/*.avro --project=scio-playground --runner=DataflowRunner --region=europe-west1 --tempLocation=gs://scio-playground/user/<username>/dataflow/tmp --output=gs://scio-playground/user/<username>/di_golden_path/output/end_content_fact_example --topN=10 --metricsLocation=gs://scio-playground/user/<username>/di_golden_path/output/_metrics
```

As `runMain` command starts, you see many logs. Typically, these are logs with category `Info` or `Warning`. After the job is submitted, you see nothing new printed for several minutes, as the job is running on Dataflow. Whether the command is successful is seen when `[success]` is printed when the job ends.

**Access control**

To get access to the data that you need for this Golden Path tutorial, join the group [scio-users](https://groups.google.com/a/spotify.com/forum/#!forum/scio-users) which will give you access to **scio-playground**. (Note, however, to access most other Spotify datasets, you will have to follow the access control procedure in [Silver Path: Data Access Control Instructions](https://docs.google.com/document/d/1R496L_8mSJf2LRJLFsnLxCwt_XIe51lHSpUfTRxaMV4/edit#).)

**Troubleshooting** If the end result is not a success:

- Make sure you are a member of [scio-users](https://groups.google.com/a/spotify.com/forum/#!forum/scio-users).
- Get logged in: run `gcloud auth application-default login`.
- If you haven’t done so when running the pipeline, set the GCP project: run `gcloud config set project scio-playground`.
- Make sure that the `GOOGLE_APPLICATION_CREDENTIALS` environment variable isn’t set.

**The runMain command and its parameters**

> Let's look at the command you just ran.

`runMain` is an **sbt** command that is used to run the main method in `com.spotify.data.example.BrownieRecsJob`, the example pipeline you have studied. You must provide the fully qualified name for the job; it isn’t enough to say `BrownieRecsJob`.

Let’s check the other parameters related to the job:

| Path                                                         | Description                                                  |
| :----------------------------------------------------------- | :----------------------------------------------------------- |
| `--input=gs://golden-path-sample-data/di.golden.path.EndContentFactXT2/2018-10-31/20181031T075406.854146-12dc225803c3/*.avro` | This is a parameter for your job that indicates from where you get input data. You need to specify each individual file that is part of the input ‒ not merely the directory that contains the files. You can use wildcards (`*`) to do this. This parameter gets passed to your pipeline through args("input"). |
| `--project=scio-playground`                                  | This is a cloud pipeline option for Dataflow. It is the Google Cloud Project ID where you want your pipeline to execute. This is necessary if you run your pipeline using the Cloud Dataflow managed service. In this case, you use the playground project, scio-playground, that we have set up for you. If you set up a different GCP project, the job will run in that project, and bill those people. However, you are only able to do so if your Google account is authorized to do so. (More on GCP permissions later.) |
| `--runner=DataflowRunner`                                    | This is a cloud pipeline option for Dataflow. It selects what PipelineRunner runs the job. The default is DirectRunner, which will run the job on your local machine. Here, you use DataflowRunner which means that sbt will submit your job to be run on Google Cloud Dataflow. |
| `--region=europe-west1`                                      | This is a cloud pipeline option for Dataflow. Dataflow workers that execute your pipeline are Google compute engine instances. This indicates in what region (defaults to us-central1) that your dataflow workers will run. |
| `--tempLocation=gs://scio-playground/user/<username>/dataflow/tmp` | This is a cloud pipeline option for Dataflow. It is the GCS path for temporary files like dependency .jars, the pipeline .jar itself and intermediate data. For your job to run on the server, the compiled and packaged code for your pipeline and all dependencies must be sent to the Dataflow service. When sbt has created the .jar files, Scio uploads them to GCS where Dataflow gets them. |
| `--output=gs://scio-playground/user/<username>/di_golden_path/output/end_content_fact_example` | This is a parameter for your job that indicates where you should store your output data. It corresponds to args(output) in the code. |
| `--topN=10`                                                  | This is a parameter for your job: the number of top tracks for user you have kept. It corresponds to args(topN) in the code. Use a parameter like this whenever you want to modify the behavior of your pipeline before it is run, based on user input. |
| `--metricsLocation=gs://scio-playground/user/<username>/di_golden_path/output/_metrics` | This parameter stores accumulators, cloud metrics, job name, job Id and other useful info about the job in Json format. To have access control for counters for ITGC compliance purposes, counters need to be stored as files (rather than in counter service) because this service doesn’t provide an access control mechanism. |

There are a few other parameters you may see often in other pipelines such as `numWorkers`, `maxNumWorkers`, `autoscalingAlgorithm` and `network`. Check the [Scio wiki](https://spotify.github.io/scio/Getting-Started.html) and [Google Cloud documentation](https://cloud.google.com/dataflow/docs/guides/specifying-exec-params#setting-other-cloud-pipeline-options) for information on how to configure your Scio/Dataflow jobs based on your needs.

When you’ve run the commands, you see that the job is submitted to Google Cloud Dataflow. To monitor the running status of the job, go to the link seen in the output log (similar to the below). The link is typically at the end of the log, but sometimes in the middle.

```
[run-main-1] INFO org.apache.beam.runners.dataflow.DataflowRunner - To access the Dataflow monitoring console, please navigate to https://console.developers.google.com/project/scio-playground/dataflow/job/2017-02-28_04_35_35-3270612440166728810
```

The job takes about 10 minutes to complete - see the following graphic.

**Viewing the output of your pipeline**

If you have gcloud installed, you can use the gsutil command (edit the command below to include your username).

```
gsutil ls gs://scio-playground/user/<username>/di_golden_path/output/end_content_fact_example
```

Alternatively, you can also view this in your browser through the Google Cloud Storage UI by visiting the output path:

```
https://console.cloud.google.com/storage/browser/scio-playground/user/<username>/di_golden_path/output/end_content_fact_example/
```

**Writing your first data pipeline**

Now you have run the example pipeline on Google Cloud. But wait, there’s more! This was just a walkthrough of the example pipeline generated from the template. Remember you are trying to answer the question:

**Who were the top 10 most streamed artists yesterday, and how many streams did they get?**

In this section, you’ll learn step by step how to write the code to answer this question.

Let’s consider how you should do it. You know how to process `EndContentFactXT`data by now. However, there’s no track or artist information on `EndContentFactXT`. You can use the track ID to join the `EndContentFactXT` data with `TrackEntity`, a dataset that contains track metadata, including the artist name. Then you’ll have the data you need to answer the question.

However, the `TrackEntity` dataset that you want to use resides in a BigQuery table, while `EndContentFactXT` is stored as Avro files on GCS. That’s not a problem: one of Scio’s strengths is its ability to crunch data residing anywhere on GCP, as batch on BigQuery and GCS, in a real-time data sources like PubSub or in databases like Bigtable or Datastore.

Scio provides two ways to load BigQuery tables: a type-safe way and a non-type-safe way.

**Why IntelliJ Scio IDEA plugin makes life easier for type-safe BigQuery**

You should have already installed the IntelliJ Scio IDEA plugin in the first section of this Golden Path. (If you haven't, go do that now.)

Like the Avro datasets in GCS, all BigQuery datasets have a schema. The difference is that BigQuery schemas are not stored in the `spotify-data-schemas` library. Scio can automatically find the schema of a given table or query, and can even generate a Scala class matching it. In the rest of this document, we’ll be using the type-safe BigQuery API. Make sure you’ve read [the relevant documentation](https://spotify.github.io/scio/io/Type-Safe-BigQuery).

Here’s how you will use the plugin later in this guide:

1. Create a new Scala case class to contain the schema of the BigQuery table you want to import (TrackEntity, in this case)
2. Decorate this class with a "macro" annotation, such as `@BigQueryType.fromTable`, `@BigQueryType.fromQuery` or `@BigQueryType.toTable`.
3. Compile your code

**At compile time**, the macro is executed to generate type-safe schema classes from BigQuery tables or queries.

```
@BigQueryType.fromTable("project:dataset.table")
class TrackEntity

val trackEntities: SCollection[TrackEntity] = sc.typedBigQuery[TrackEntity]()
```

In theory, the code compiles without plugins. However, due to a bug in IntelliJ syntax highlighting for macro annotations, this does not work properly.

**Let’s start coding**

Now we will create a new Scio job and then go through an example of building a data pipeline computing who were the top 10 most streamed artists yesterday, and how many times their songs were streamed. The complete code example is [here](https://ghe.spotify.net/pages/scala/goldenpath-example/TopArtistsJob.scala.html).

Note that the case class definitions need to be outside the main method. Also that the BigQuery annotated classes need to live inside a class/object (it can be the same object that main is in, or another one).

**Create a new Scio job**

Start by creating a new Scala object called **TopArtistsJob** in package **com.spotify.data.example**. Paste in the code from the example [here](https://ghe.spotify.net/scala/goldenpath-example/blob/master/goldenpath-example/src/main/scala/com/spotify/data/example/TopArtistsJob.scala).

![image alt text](https://backstage-proxy.spotify.net/api/docproxy/data-engineering-golden-path/part-2-creating-and-running-a-data-pipeline/img/image_1.png)

## Helper classes and methods[¶](https://backstage.spotify.net/docs/data-engineering-golden-path/part-2-creating-and-running-a-data-pipeline/7-lets-start-coding/#helper-classes-and-methods)

Instead of using `EndContentFactXT` which has a lot of fields we are not interested in, we will convert `EndContentFactXT` instances into a custom, smaller, case class `EndContentFact`. This will also allow us to get rid of all the unused fields, and to replace the nullable fields by instances of `Option`.

Let’s define a few classes and helper methods that you will use later in the pipeline.

Add this to your imports block

```
import com.spotify.coredata.schemas.`EndContentFactXT`
import com.spotify.scio.avro._
import com.spotify.scio.bigquery._
import com.spotify.scio.bigquery.types.BigQueryType
import com.spotify.scio.values.SCollection
```

We will be creating our own stripped down version of `EndContentFactXT`, named just `EndContentFact`.

Copy/paste the code snippets below into the file you just created, below the main method, within the `TopArtistsJob` object.

```
case class EndContentFact(trackId: String,
                          incognitoMode: Boolean,
                          msPlayed: Long,
                          isSkipped: Boolean)
```

This is a stripped down version of the Avro `EndContentFactXT` which only contains the fields you need for this pipeline.

```
case class Artist(id: String, name: String)
```

This is a case class representing one artist. Just in case there are some artists with the same name (*e.g.*, "Julian Angel", “Night Moves”), the artist id is included, so every case class instance is unique.

```
case class TrackArtist(trackId: String, artist: Artist)
```

This is a case class representing the relationship between a track and its artist(s).

```
def getEndContent(endContentFact: `EndContentFactXT`): Option[EndContentFact] = {
 Try(
   EndContentFact(
     endContentFact.getPlayTrack.toString,
     endContentFact.getUserBehavior.getIsIncognito,
     endContentFact.getMsPlayed,
     endContentFact.getUserBehavior.getIsSkipped
   )
 ).toOption
}
```

`getEndContent` converts an Avro record of `EndContentFactXT` to an instance of your own `EndContentFact` case class.

First, it tries to get the `PlayTrack`, `IncognitoMode` status, `MsPlayed`, and `Skipped`field from the Avro record `endContentFact`. Then, it tries to create an instance of our `EndContentFact` case class using those extracted values.

In this code, `getPlayTrack` can sometimes return `null`, that is, a java null value, because Avro objects are Java objects.The problem is, if your pipeline tries to call `.toString` on a `null` value when it’s running, it throws a `NullPointerException`and crashes.

To prevent the pipeline from crashing, we handle the potential Exception using `Try`. (See [Try in scaladoc](https://www.scala-lang.org/api/current/scala/util/Try.html)). In this example, problematic values will simply be discarded, so we turn that `Try` into an [Option](https://www.scala-lang.org/api/current/scala/Option.html).

Note

Add `import scala.util.Try` to your import block.

```
def isValidEndContent(e: EndContentFact): Boolean = {
  e.msPlayed >= 30000 && !e.incognitoMode && !e.isSkipped
}
```

As usual, we’ll use `isValidEndContent` to filter invalid `EndContentFact`.

```
@BigQueryType.toTable
case class ArtistCount(id: String, name: String, count: Long)
```

We use [BigQueryType.toTable](https://spotify.github.io/scio/io/Type-Safe-BigQuery.html#bigquerytype-totable) to automatically generate the code required to safely write to BigQuery.

```
@BigQueryType.fromQuery(
 """
   |#standardSQL
   |SELECT
   |  track_gid,
   |  artist.artist.gid AS artist_gid,
   |  artist.artist.name AS artist_name
   |FROM `scio-playground.di_golden_path.track_entity_20181031`,
   |     UNNEST(master_metadata.artist) AS artist
   |WHERE track_gid IS NOT NULL
   |  AND artist.artist.gid IS NOT NULL
   |  AND artist.artist.name IS NOT NULL
 """.stripMargin)
class TrackEntity
```

We also use [BigQueryType.fromQuery](https://spotify.github.io/scio/io/Type-Safe-BigQuery.html#bigquerytype-fromquery) to read from the table named `scio-playground:di_golden_path.track_entity_20181031`.

Note

Since you only need three columns `(track_gid`, `artist.artist.gid` and `artist.artist.name`) from the `master_metadata.artist` table, you can select these instead of fetching the whole table. It is efficient to do so since BigQuery is a columnar storage, so it reads only the columns needed for a query. Such optimization greatly reduces the amount of data processed and transferred in the first two steps of your pipeline.

The important message: think about what you're reading from, GCS or BigQuery, and leverage BigQuery's features whenever you use BigQuery.

Here, your query:

1. Flattens your query results (`UNNEST`) since `master_metadata.artist` is a repeated field.
2. Filters out all undesired data (that is, data with `null` values)
3. Extracts only the desired columns, that is, `track_gid`, `artist_gid` and `artist_name`.

Let’s take a look at the following simplified example to understand your query. In this case, there are two columns, `track_gid` and `artist` in `TrackEntity`, and you have three sample records in your table:

| `track_gid` | `artist`                                                     |
| :---------- | :----------------------------------------------------------- |
| `1`         | `[gid: 11, name: Tim], [gid: 22, name: null], [gid: 33, name: Peter]` |
| `2`         | `[gid: 33, name: Peter], [gid: null, name: Mark], [gid: null, name: null]` |
| `3`         | `[gid: 33, name: Peter], [gid: 44, name: Peter]`             |

If you run your query on this sample table, you get the following results:

| `track_gid` | `artist_gid` | `artist_name` |
| :---------- | :----------- | :------------ |
| `1`         | `11`         | `Tim`         |
| `1`         | `33`         | `Peter`       |
| `2`         | `33`         | `Peter`       |
| `3`         | `33`         | `Peter`       |
| `3`         | `44`         | `Peter`       |

When you run `sbt compile`, a dry run to BigQuery is executed to fetch the schema of the query results and generate the case class.

**Tips**

> If you run into `java.lang.RuntimeException`, you need to set the Property `bigquery.project`.
>
> Use `-Dbigquery.project=<Billing project>`
>
> Run `sbt` like this: `sbt -Dbigquery.project=scio-playground`
>
> Or modify `.sbtopts` under the root of the repository:
>
> Uncomment `-Dbigquery.project=<your-bigquery-project-id>` and change it to `-Dbigquery.project=scio-playground`
>
> If you happen to be on windows you might get this error even if you have configured gcloud accordingly. This is because the location of the default gcloud configuration file has been moved. As a workaround you can copy the configuration file to the location where it is expected to be using this command:
>
> ```
> copy %APPDATA%\gcloud\configurations\config_default %APPDATA%\gcloud\properties
> ```

In order to make IntelliJ run smoothly, re-compile your project every time you add this kind of macro annotation from a table or from a query. You are supposed to see something resembling the following logs if the compilation is successful:

```
[pool-6-thread-1] INFO com.spotify.scio.bigquery.types.TypeProvider$ - Will dump generated TrackEntity of com.spotify.data.example.TopArtistsJob from /Users/marklaw/di-golden-path-pipeline/di-golden-path-pipeline/src/main/scala/com/spotify/data/example/TopArtistsJob.scala to /var/folders/1r/fsfhjwg96kb673f4j7mfn7yh0000gn/T/bigquery-classes/TrackEntity-8caf12ef.scala
```

Using the already installed Scio plugin, IntelliJ should now recognise the newly generated case class(es) and provide you with auto-completion.

** Deep dive into the pipeline logic**

The code starts by creating a `ScioContext` and reading a few parameters from the command line:

```
val (sc, args) = ContextAndArgs(cmdlineArgs)

val endContentFact = args("endContentFact")
val textOutput = args("textOutput")
val bqOutput = args("bqOutput")
val topN = args.int("topN")
```

Here args(`"endContentFact"`) indicates the GCS path where the `EndContentFactXT` Avro dataset resides. This path must match either a single filename, or a file pattern (also called a “glob”).

In this pipeline, the output is stored both in GCS as plain text and in a BigQuery table. Therefore, you have both `textOutput` and `bqOutput`.

> Many production pipelines have only one output, but for demonstration purposes, here you see two.

### Counting the number of times each track has been played[¶](https://backstage.spotify.net/docs/data-engineering-golden-path/part-2-creating-and-running-a-data-pipeline/7-lets-start-coding/#counting-the-number-of-times-each-track-has-been-played)

Let’s start by reading the `EndContentFactXT` data and convert them to `EndContentFact`:

```
val endContentRaw: SCollection[`EndContentFactXT`] =         
  sc.avroFile[`EndContentFactXT`](endContentFact)

val endContent: SCollection[EndContentFact] = 
  endContentRaw.flatMap(getEndContent)
```

Just like in the previous example, we only want to keep valid tracks:

```
val validEndContent: SCollection[EndContentFact] = 
  endContent.filter(isValidEndContent)
```

Then, extract the `trackId` out of the `EndContentFact` data and you get a `SCollection` of track IDs as strings:

```
val trackIds: SCollection[String] = 
  validEndContent.map(endContent => endContent.trackId)
```

Like the template example, use `countByValue` to count the number of appearances of each unique value in the `SCollection` In this case, the number of times that each track ID appears in the data, which is equivalent to the number of times it was played on this day.

```
val trackCounts: SCollection[(String, Long)] = trackIds.countByValue
```

If you are more familiar with SQL, consider `trackIds` as a table `T` with a single column, `trackId`. Then `trackIds.countByValue` is similar to:

```
SELECT trackId, COUNT(trackId)
FROM T
GROUP BY trackId
```

Keep in mind that this is not how Scio works behind the scenes, but it may help you understand better if you have an SQL background.

Here, `countByValue` returns a `SCollection` of (`trackId: String, count: Long`) tuples.

**Fetching artists information**

After these transformations, you know how many times each track was played on the given day. You only need to join the tracks with their artists, to know which artists had the most streams. To do this, you can use Scio’s `.typedBigQuery()`method to load `TrackEntity` from BigQuery:

```
// Make sure this import is present to get access to .typedBigQuery().
import com.spotify.scio.bigquery._

val trackEntities: SCollection[TrackEntity] = 
  sc.typedBigQuery[TrackEntity]()
```

This is a `ScioContext` source method, similar to `sc.avroFile`, which lets you load the BigQuery table into aa `SCollection`. (Type `sc.` in IntelliJ to see what other source methods are available.)

Tip

For `typedBigQuery` to work, `TrackEntity` had to be annotated with either `BigQueryType.fromSchema`, `BigQueryType.fromTable`, `BigQueryType.fromQuery`, or `BigQueryType.toTable`. `typedBigQuery` only works for types that have one of those annotations. This constraint is checked by the compiler so if you try to use `typedBigQuery` on a non-annotated type, the code will fail to compile.

This method executes the query and loads the results (and give an `SCollection`with millions of elements), which is what we’ll need for the Top10 pipeline.

> **Extracting data using a different SQL query** While the `typedBigQuery` method can automatically access the BQ table, it also lets you pass a custom SQL query. For example, you may want to limit the number of results returned to a number `limitN` passed to your pipeline as an argument:
>
> ```
> val trackEntities: SCollection[TrackEntity] = 
>     sc.typedBigQuery[TrackEntity](s"""
>         SELECT * 
>         FROM `scio-playground.di_golden_path.track_entity_20181031` 
>         LIMIT ${args.int("limitN")}
>     """)
> ```
>
> In that case you need to make sure the schema of the result of this query matches the schema used to generate `TrackEntity`. If not, the execution will fail at runtime.
>
> This feature is commonly used to build pipelines using the schema from a fixed table (for example using `@BigQueryType.fromTable`), while still querying BigQuery dynamically. For example, when the data is partitioned.
>
> Keep this important distinction in mind: the macro annotations like `@BigQueryType.fromTable` query the table schemas at compile time, but the `typedBigQuery` function is executed at runtime.

Let’s now define and use the `getTrackArtists` method to and the classes it uses:

```
def getTrackArtists(entity: TrackEntity): Option[TrackArtist] = {
    for (
      trackGid <- entity.track_gid;
      artistGid <- entity.artist_gid;
      artistName <- entity.artist_name
    ) yield TrackArtist(trackGid, Artist(artistGid, artistName))
  }
```

As usual, these definitions are supposed to reside outside of the main method.

Tip

More explanations about the implementation can be found in the commented source.

You can now use `getTrackArtists` on `trackEntities`:

```
val flattenTrackArtists: SCollection[TrackArtist] = 
  trackEntities.flatMap(getTrackArtists)

val trackId2Artist: SCollection[(String, Artist)] =
  flattenTrackArtists.map(ta => (ta.trackId, ta.artist))
```

Here, you prepare the format to join with `trackCount` by transforming each `TrackArtist` object to be a pair of `trackId` and `Artist`.

**Joining track count with artists**

```
val trackId2ArtistAndCount: SCollection[(String, (Option[Artist], Long))] =
  trackId2Artist.rightOuterJoin(trackCounts)
```

`SCollection`’s "`join`" function, one of the many functions available on `SCollections` of pairs, behaves like a SQL join, but applies to `SCollections`instead of tables. You join `trackId2Artist` and `trackCounts` by `trackId` (the first element on the pairs).

You want to keep track of the number of tracks that you cannot join to make sure you don’t produce nonsense data. We do so by using counters.

```
val artistAndTotalCounts: SCollection[(Artist, Long)] = 
  trackId2ArtistAndCount
    .flatMap {
      case (_, (Some(artist), trackCount)) =>
        successfulyJoinedTracks.inc()
        Option((artist, trackCount))
      case (_, (None, _)) =>
        noArtistTracks.inc()
        None
    }
    .sumByKey
```

Here, you use `sumByKey` to sum all the track counts for each artist. `sumByKey` is an operation that relies on an algebraic data structure provided by [Algebird](https://twitter.github.io/algebird/), [Semigroup](https://twitter.github.io/algebird/typeclasses/semigroup.html). This and other powerful transforms like `sum`, `aggregate`, `aggregrateByKey` are available in Scio by leveraging [Algebird](https://twitter.github.io/algebird/).

```
val topArtistByTotalCounts: SCollection[(Artist, Long)] = 
  artistAndTotalCounts
    .top(topN, Ordering.by(_._2))
    .flatten
```

You already have the total stream counts for all artists from the previous steps. In this step, you are going to find the ones with the highest counts by using the [top function](https://spotify.github.io/scio/api/com/spotify/scio/values/SCollection.html#top(num:Int,ord:Ordering[T])(implicitcoder:com.spotify.scio.coders.Coder[T]):com.spotify.scio.values.SCollection[Iterable[T]]).

It is a curried function, so uncurry it with the number of top artists you want to keep in the output. Define how to order the artist using the second element in the tuple (the total stream counts).

Note

`Top` returns an `SCollection` with one element which is an iterable with size N, not a `SCollection[T]` with N elements. In this case, it is a `SCollection[Iterable[(Artist, Long)]]`. Call `.flatten` to convert it into an `SCollection[(Artist, Long)]` of size `N`.

```
topArtistByTotalCounts.saveAsTextFile(textOutput)
```

Save the result to GCS as a plain text as before.

```
topArtistByTotalCounts.map {
  case (artist: Artist, count: Long) => 
    ArtistCount(artist.id, artist.name, count)
}.saveAsTypedBigQuery(bqOutput)
```

Save the result in a BigQuery as a table.

Transform your result to use the case class `ArtistCount` which is annotated with `BigQueryType.toTable`.

There are two optional parameters for `saveAsTypedBigQuery` that you should omit and use the default values:

1. `WriteDisposition`
2. `CreateDisposition`

`WriteDisposition` has three options: `WRITE_TRUNCATE, WRITE_APPEND` and `WRITE_EMPTY`. The default value is `WRITE_EMPTY`, which means that you only write if the destination table is empty. Learn more [here](https://cloud.google.com/bigquery/docs/reference/rest/v2/jobs#configuration.query.writeDisposition).

`CreateDisposition` has two options: `CREATE_NEVER` and `CREATE_IF_NEEDED`. The default value is `CREATE_IF_NEEDED`, which means if the table doesn’t exist, a new one is created. Learn more [here](https://cloud.google.com/bigquery/docs/reference/rest/v2/jobs#configuration.query.createDisposition).

```
sc.close()
```

Close the `ScioContext` and submit your pipeline to the runner.

**Running the pipeline in Google Cloud**

First you need to create a dataset in the UI as described in the following figures. Go to https://console.cloud.google.com/bigquery?project=scio-playground&p=scio-playground&page=project.

Click **CREATE DATASET**.

Give your username as the dataset Id. Select the **European Union (EU)** as the data location and make the data expire in 7 days or so:

You should now understand the following commands. Remember to substitute your own username in the appropriate place in the commands.

```
$ sbt
> project di-golden-path-pipeline-<username>
> runMain com.spotify.data.example.TopArtistsJob --runner=DataflowRunner --project=scio-playground --region=europe-west1 --tempLocation=gs://scio-playground/user/<username>/dataflow/staging --endContentFact=gs://golden-path-sample-data/di.golden.path.EndContentFactXT2/2018-10-31/20181031T075406.854146-12dc225803c3/*.avro --textOutput=gs://scio-playground/user/<username>/di_golden_path/top_artists/ --bqOutput=scio-playground:<username>.top_artists --topN=10
```

If you get permission errors, join [scio-users](https://groups.google.com/a/spotify.com/forum/#!forum/scio-users); that group has access to scio-playground.

View the pipeline running status in the dataflow UI:

Along with the job graph, you can see the values of any custom counters you created in your job. In a later step in the golden path you’ll learn how to persist and monitor these counters. Additionally, clicking on each step in the graph will show you useful metrics such as input size, wall time, etc.

After the pipeline is done, check the output in GCS and BigQuery to see whether it is what you expected. Run the following command in a terminal shell (not an sbt shell!)

```
# use only for small datasets, like this one
# Cat files:
gsutil cat gs://scio-playground/user/<username>/di_golden_path/top_artists/part-00000-of-00001.txt
```

At this point, you should have a working pipeline.

**BigQuery vs GCS**

A quick rundown; BigQuery is nice if:

- You want analysts to have easy access to your dataset
- You read only a few fields (i.e., no SELECT *)
- You do grouping/filtering in your query before processing in Scio

On the other hand, GCS has a lot of pros

- Performance: reading / writing to GCS is faster than BigQuery.
- Scalability: Bigquery has limited computational capacity. If you process a lot of data, it may be a bottleneck.
- Predictability: BigQuery capacity is shared. Someone running a slow query may negatively impact you pipeline execution time.
- Cost

Please consider this before choosing GCS/BigQuery/... as your storage location.

**Testing your pipeline**

Your pipeline now runs, but the feedback loop in case of mistakes in your code is still quite long. You can create a test for our pipeline and get feedback in just seconds. You can find a test for the pipeline created above by clicking [this link](https://ghe.spotify.net/scala/goldenpath-example/blob/master/goldenpath-example/src/test/scala/com/spotify/data/example/TopArtistsJobTest.scala). You can also find documentation about Scio’s test api [in the wiki](https://spotify.github.io/scio/Scio-Unit-Tests).

To run the test, you can run the following commands. You can skip the first two lines if you already ran them and are still in the sbt shell.

```
$ sbt
> project di-golden-path-pipeline-<username>
> test
```

Have a look at the [commented source code](https://ghe.spotify.net/scala/goldenpath-example/blob/master/goldenpath-example/src/test/scala/com/spotify/data/example/TopArtistsJobTest.scala) to understand how tests are defined.

A more detailed description and examples on how to write various Scio unit tests is on the [github wiki](https://github.com/spotify/scio/wiki/Scio-Unit-Tests).

**Test tooling**

In this test, we use a couple of open-source tools we created to generate random data and assert the correct behaviour of our newly created pipeline:

[Ratatool](https://ghe.spotify.net/scala/ratatool-internal) A library that provides [ScalaCheck](http://scalacheck.org/) data generators for Spotify data types. If ratatool doesn’t have a generator for the record you’re using, you can write your own generator ([examples](https://github.com/spotify/ratatool/blob/master/ratatool-examples/src/main/scala/com/spotify/ratatool/examples/scalacheck/GenExample.scala)) or construct the record manually. In this example, manual record construction would look like: `EndContentFactXT.newBuilder().setMsPlayed(...).setUserId(...)...build()`

[Data Generators](https://github.com/spotify/ratatool/wiki/Generators) Data Generators create data of a user-specified type, with optional additional user-specified constraints. This data is then often used for testing.

See [SCollectionMatchers.scala](https://github.com/spotify/scio/blob/master/scio-test/src/main/scala/com/spotify/scio/testing/SCollectionMatchers.scala) for more matchers to use in your test and [scio-examples](https://github.com/spotify/scio/tree/master/scio-examples/src/test) for some more examples of pipeline tests.

**Checking the content of an Avro file**

Once you’ve completed those exercises, you may want to check the content of the generated avro files. You can easily do it using **gsutil** and [avro-tools](https://github.com/spotify/gcs-tools) (which is available from the public Spotify Homebrew tap).

Start by using gsutil to inspect your output directory, which will list specific file names:

```
$ gsutil ls gs://<gcs-bucket>/<output-dir>
```

Once you know the full path spec of the Avro file, you can use avro-tools to visualize the content as json:

```
$ avro-tools tojson gs://<gcs-bucket>/<output-dir>/<file-name>.avro
```

You can even pipe the output into [jq](https://stedolan.github.io/jq/) to get a nice formatted and colored output:

```
$ avro-tools tojson <path-to-avro-file> | jq
```

