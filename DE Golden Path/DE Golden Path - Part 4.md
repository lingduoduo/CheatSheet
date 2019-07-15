### Introduction

Now that you have successfully created and test-run your batch data processing pipeline you will need to deploy it to Styx and define when it is to be scheduled to run automatically. This section of the Golden Path walks you through the processes of building, deploying and scheduling your data pipeline to the Google Cloud platform. Along the way you encounter many of the tools you use for these processes. Usually, you need only a web browser (Google Chrome or Firefox) and a console window by which you deploy and schedule your data pipeline.

By the end of this tutorial, you will be able to:

- Set up a Google Cloud production environment
- Build a data pipeline using Tingle
- Deploy a Docker image to the Google Container Registry (GCR)
- Execute the Docker image to the Google Container Engine (GKE)
- Schedule your pipeline jobs using the Styx scheduler

### Understanding Tingle, Styx and Google Cloud[¶](https://backstage.spotify.net/docs/data-engineering-golden-path/part-4-deploying-and-scheduling-a-data-pipeline/2-understanding-tingle-styx-and-google-cloud/#understanding-tingle-styx-and-google-cloud)

[Tingle](https://backstage.spotify.net/docs/tingle/) is a Spotify-built event-driven continuous delivery service. It coordinates events from GHE (like PR created, push to master etc.) and triggers the relevant build-jobs. It then gathers build results and serves the feedback to different systems (Backstage and GHE).

When you have written your data pipeline code in IntelliJ and pushed it to GHE, Tingle compiles this source code to machine-readable code (artifact). In this context, an [EdgeDocker base](https://confluence.spotify.net/display/DI/Docker) (template) simplifies packaging and deploying the data pipeline as a Docker image.

Styx is Spotify’s scheduling service executing Docker containers as batch jobs. The scheduler has been developed to execute [workflows](https://confluence.spotify.net/display/DI/Concepts+and+Terminology) on Google Cloud Platform. A workflow execution typically produces output, published as one or more [data endpoints](https://confluence.spotify.net/display/DI/Concepts+and+Terminology#ConceptsandTerminology-DataEndpoint). For more information about Styx, its features and benefits, see [here](https://confluence.spotify.net/display/DI/Styx).

[Google Cloud Platform](https://confluence.spotify.net/display/GCP/Google+Cloud+Platform) is Spotify’s third-party data center that is used for processing and storage of your data. For more information on Google Cloud Storage (GCS) see [here](https://confluence.spotify.net/display/BSD/Google+Cloud+Storage+-+How+to).

### Working in Google Cloud

Spotify uses Google Cloud to process, analyse and store data in projects and buckets. This section of the tutorial provides the basics for accessing Google Cloud and creating projects and storage buckets.

If you are learning about data pipelines, you can use the project that is already set up, called [scio-playground](https://console.cloud.google.com/home/dashboard?project=scio-playground). It includes a service account that you can use (the [Compute Engine default service account](https://console.cloud.google.com/iam-admin/serviceaccounts/project?project=scio-playground)). In this case, skip to [Configure Docker Repository](https://backstage.spotify.net/docs/data-engineering-golden-path/part-4-deploying-and-scheduling-a-data-pipeline/3-working-in-google-cloud/#heading=h.708isgoe3x3s).

If you are putting a data pipeline or a set of data pipelines into production, you need to set up a new project. Follow these instructions:

###  Creating a project in Google Cloud

If the feature or system that you work on doesn’t yet have a project assigned, create a new Google Cloud project. To do this, go to [this page](https://backstage.spotify.net/projects-owned) and click **CREATE NEW PROJECT**.

### Creating a service account

In order to create a service account with the correct permissions set up, follow [this guide on Confluence](https://confluence.spotify.net/display/DI/Setting+up+a+GCP+Service+Account).

Granting appropriate permissions to Styx to pull from GCR of your project

Let Styx pull from your project's GCR by giving `deploy-agent-service-accounts@spotify.com` the **Storage Object Viewer** role on the GCS bucket `artifacts.[project-id].appspot.com` in Cloud Console.

Note

If you don't see the bucket, you haven't pushed any image of your project to GCR. In this case, follow the section below Configure Docker Repository followed by sbt dockerBuildAndPush to create the bucket.

### Configure Docker Repository

Update your dockerRepository in your `build.sbt` file to `<your-newly-created-gcp-project-id>`or `scio-playground`if you use that project and if it is not already.

dockerRepository := s"gcr.io/scio-playground/${pipeline.id}"

### Declaring your service account in the workflow specification

Styx needs to know which service account a workflow should be associated with. Therefore, add a key-value pair in the `data-info.yaml` file, with key `service_account` and the ID of your above created service account, or the **Compute Engine default service account** (`618549034297-compute@developer.gserviceaccount.com`) in `scio-playground`.

```
facts:
  # some other parameters, and then this new stuff:
  data_endpoints:
    # the ID should be consistent with the Luigi task class name,
    # for Datamon to reflect running status
    - id: di.golden.path.<username>.top_artists
      partitioning: DAYS

  workflows:
    - id: di_golden_path.<username>.TopArtistsJob
      schedule: daily
      service_account: my-service-account@example.com
      docker_args:
        - 'wrap-luigi'
        - '--module'
        - 'top_artists'    # The file your Luigi task is in, as per GP #2
        - 'TopArtistsJob'   # Your Luigi task class name
        - '--top-n=10'
        - '--date'
        - '{}'
```

### Declaring your service account in the Luigi task

If you want the Dataflow job to use your service account instead of the **Compute Engine default service account** (`618549034297-compute@developer.gserviceaccount.com`), you should declare the service account in the Luigi task as shown the following example:

```
class TopArtistsJob(ScioJobTask):
    service_account = 'my-service-account@example.com'
```

### Creating a bucket in Google Cloud Storage

You will need to create your own bucket to store the generated data. To create a bucket, follow the instructions below and add the following under `docker_args`:

```
 - '--uri-prefix=gs://<your-bucket-name>'
```

Tip

For this to work, you need to adapt `top_artists.py` to take in the `uri_prefix`parameter similar to `BrownieRecsJob` in `luigi_tasks.py`.

Within the project that you just created, you now have to create a bucket in Google Cloud Storage. A bucket is a container similar to a virtual hard drive and it is used to store, organize and access your project data. When you create a bucket you have to give it a name, a default storage class and a geographical location from where you or anyone with the appropriate permissions can access it. A bucket name must conform to DNS naming conventions. The geographical location of a bucket can be set to regional or multi-regional. You can read more about that [here](https://docs.google.com/document/d/1HboiqXZUUOHFM0vEp_lEBxbUgjJSBpx_6S3AQ89HrB0/edit#heading=h.gtjt6j58ae4d).

This is how you create a bucket or a list of buckets:

1. Select your project in the [Google Cloud console](https://console.cloud.google.com/).
2. Click **Storage** in the side menu.
3. Select **Browser**.
4. Click **CREATE BUCKET**. The following window appears.

1. Enter a **name**, **default storage class** and **location** in the dialog window. You can give your bucket any name you like, as long as it is unique. You typically select a data endpoint name. The location you select must be within Europe. This is in line with Spotify standards that our GCP data is colocated in Europe.
2. Choose the desired Access control model.
3. Click **Create**.

### Giving your service account permissions to the new bucket

1. Go back to **Browser**.
2. On your newly created bucket, click **:>Edit bucket permissions**, type your service account, and select **Storage Admin** role.
3. Click **Add**.

In practice, you should always give your service account minimum required permissions (roles). For more details, see [Using Identity and Access Management (IAM) Permissions](https://cloud.google.com/storage/docs/access-control/using-iam-permissions).

To finish the Golden Path, apart from **Storage Admin**, the following roles are also required:

- Dataflow Worker
- Dataflow Admin
- BigQuery Data Editor
- BigQuery Job User

### End-to-end test running a workflow

To verify the previous steps, that is, the correct service account specification and permission settings, you can use the **qstyx** tool ([quick-styx](https://ghe.spotify.net/datainfra/quick-styx)).

Install **quick-styx** as follows:

**Mac OS**

```
# it is recommended to install in a virtualenv if you use Mac
$ pip install -i https://pypi.spotify.net/simple/ spotify-quick-styx
```

**Linux**

```
$ apt-get install spotify-quick-styx
```

**quick-styx** lets you run your fully configured workflow in a Docker image locally on your computer. Note that doing so the workflow code will run using the specified service account, will read your actual input data endpoint partitions, and produce actual output, as if in a production scheduled run.

Note

If you have run the job in the previous part of the Golden Path, follow the Hades note at the end of this document to unpublish first.

Note

If you get a warning stating that the service account has too many keys you need to go to the service account in question and delete some of the oldest keys.

```
$ sbt clean package docker
$ qstyx run -f data-info.yaml -w di-golden-path-pipeline-<username>.TopArtistsJob -p 2018-10-31 -r  di-golden-path-pipeline-<username>/target/image-name
```

### Adding collaborators to your GHE project

It's always useful to add your squad members as collaborators to the project, so that they can approve and merge Pull Requests in it.

1. Go to the GHE repository.
2. Click **Settings** in the top menu bar.
3. Click **Collaborators** in the left sidebar.
4. Add collaborators to your projec

### Registering your component (data pipeline) in Backstage

Backstage is your pipelines registry. It helps us keep track of your data endpoints and workflows, and provides shortcuts to common development and operational procedures. Backstage holds information about many types of components, including services, data stores, libraries, websites, in fact, every component in your development or production environment that you want to keep track of. You cannot deploy a pipeline to your production environment until it has been registered in Backstage.

In the next step you will register your new pipeline with Backstage.

Note

If you chose to register your pipeline when you created the repository ([Creating a GHE repository for your pipeline using Backstage](https://backstage.spotify.net/docs/data-engineering-golden-path/part-2-creating-and-running-a-data-pipeline/3-creating-a-ghe-repository-for-your-pipeline/)) in Creating and Running a Data Pipeline), you don’t have to follow this step. You can check whether your pipeline is already registered by searching for your component in Backstage.

You register your pipeline by telling Backstage where your pipeline information file is located:

1. Open [Backstage](https://backstage.spotify.net/).
2. Click the **+** button in the toolbar.
3. Select **Register Existing Component.**

Note

Do not be confused by the filename: we use data-info.yaml for data pipeline components and service-info.yaml for service components. Complete documentation about the content and syntax of data-info.yaml files can be found [here](https://confluence.spotify.net/display/DI/Define+Schema+in+Sysmodel).

1. Navigate to `data-info.yaml` on GHE, and copy its full URL to the input field; if you created the GHE repository [as described in GP032]([Creating a GHE repository for your pipeline using Backstage](https://backstage.spotify.net/docs/data-engineering-golden-path/part-2-creating-and-running-a-data-pipeline), it should look like this:

```
https://ghe.spotify.net/<username>/di-golden-path-pipeline-<username>/blob/master/data-info.yaml
```

1. Click **REGISTER COMPONENT**.
2. After a few minutes you should be able to search for and find your pipeline in Backstage.
3. While you are in Backstage, take the opportunity to click around and explore other features.

Note

The data information file is in a [YAML](http://www.yaml.org/spec/1.2/spec.html)-format and stores basic metadata about your pipeline, including its name and ownership. For more about data information files (and about Backstage) in Confluence, see [Defining Components Using YAML](https://confluence.spotify.net/display/SYS/Defining+Components+Using+YAML).

### Integrating and building data pipelines using Tingle

Tingle is a fully managed service for continuous integration and delivery of code. You use Tingle to compile, test, package as a Docker image, and deploy your data pipelines. The Docker images are then published to our internal GCR. Tingle passes on scheduling information to Styx, which then runs your data pipeline with the configured schedule.

Note

If you are still using Jenkins for building and deploying your pipeline, you can find information [here](https://docs.google.com/document/d/1kdboFvITaZCgc7uTe1t4cN2a7vYFX8uMLAlr8FfMpqU/edit#heading=h.gxmf41csnck3).

### Continuous Integration

Our code toolchain is based on Tingle, Github Enterprise, and build files checked into your Git projects.

Every time you change the source code of your data pipeline locally and you commit it to your GHE project repository (either in a PR or on the master branch), Tingle is triggered and will automatically build the files in the GHE repository. Next, Tingle creates a Docker image that is pushed to GCR. See also the [overview diagram](https://docs.google.com/drawings/d/1J-PlxshJYotzT5l9QxAxunzXeMcl87Qb_C6fYFyUd94/edit).

Note

If you wish to understand why we prefer Continuous Integration (CI) / Continuous Delivery (CD) as a software engineering approach, take a look at [this Wikipedia article](https://en.wikipedia.org/wiki/Continuous_delivery)and [this booklet](https://drive.google.com/a/spotify.com/file/d/0B2IE2OdHiNZ6dmd1a2NCRGJaNHc). If you are interested in how to avoid pitfalls, check [here](https://io.spotify.net/io/docs/01-backend-development/tutorial-Setup-CI-CD.html).

Tip

For information about setting up CI/CD for a backend service, we recommend [this tutorial](https://io.spotify.net/io/docs/01-backend-development/tutorial-Setup-CI-CD.html).

### Enable Tingle for your pipeline

Tingle needs to be enabled for your pipeline. To do this, you need to add a webhook to the GHE repository to notify Tingle whenever a change happens on your master branch or on a Pull Request that is in progress. The service that handles notifications from GHE in Tingle is called Knightcrock. You can then see the result from the build in your Pull Request view in GHE or in Backstage under the CI/CD tab for your component.

Follow these instructions:

### Add a webhook in GHE to the following URL: http://knightcrock.services.tingle.spotify.net

It is also important that the **Content type** field is filled with **application/json**, otherwise Tingle will not be able to handle the messages.

Note

All existing GHE repos should already have the knightcrock webhook, and thus should automatically be picked up by Tingle once the build-info.yaml is present (see below).

### Enable feedback service

This is to enable Tingle to send comments, updates to pull requests.

a) If the repo owner is an organization

Make sure the feedback-service user is an Owner of the organization under the **People** tab

b) If the repo owner is a regular user

Make sure the feedback-service user is a Collaborator for the project

### Give Tingle build agent permission to push to GCR

`build-agent@xpn-tingle-1.iam.gserviceaccount.com` needs Storage Admin permission of your project GCR bucket (`artifacts.<gcp-project-id>.appspot.com`) to be able to push images.

### Deployment credentials

Tingle needs the credentials for a service account, which will be used for deploying the workflow to Styx. If you are using the `scio-playground` project, follow [these ](https://cloud.google.com/storage/docs/renaming-copying-moving-objects)instructions using `gsutil` to copy the key `google-application-credentials.json` from the bucket `gs://scio-playground-deploy-to-styx-key`in the `scio-playground` project to the GCS bucket under the path `<own-created-bucket>/<org>/<repo>` where `<own-created-bucket>` can be anything you choose and `<org>/<repo>` is the name of your GHE repo.

If you are using another project, you need to create a JSON web key for the service account that you specified previously. Follow the instructions [here](https://cloud.google.com/iam/docs/creating-managing-service-account-keys). Rename the downloaded key file to `google-application-credentials.json`. This file must now be uploaded to a GCS bucket under the path `<own-created-bucket>/<org>_/<repo>` where `<own-created-bucket>` can be anything you choose and `<org>/<repo>` is the name of your GHE repo. To upload this file, follow [these](https://cloud.google.com/storage/docs/uploading-objects) instructions. For both https://ghe.spotify.net/datainfra/edgedocker/commits/mastercases, `scio-playground` project and other project, for Tingle to be able to read your credentials file, add `build-agent-mounter@xpn-tingle-1.iam.gserviceaccount.com` with the **Storage Object Viewer** role to the desired bucket.

### Set up your **build-info.yaml** file

If you created your component using the Backstage template, this file already exists and you can skip this step. a) Add a `build-info.yaml` file in the repository root. b) Add the below to the .yaml file.

```
# the doc:
# https://backstage.spotify.net/docs/tingle/tingle-templates/scio-pipeline/
#
version: 2
template:
  type: scioPipeline
secrets:
  bucket: <bucket-name>
```

Note

If your Scio pipeline uses BigQueryType, uncomment the line in .sbtopts and specify your BigQuery project ID.

Note

If you have sensitive data other than service account credentials that need to be accessed from within the workflow, you can use styx-secrets.

Controlling the build

If you want to change what Tingle does, you can do advanced customizations of Tingle by creating your own pipeline definitions.

### Controlling and verifying your workflow

You can find information in Backstage about any workflow that is defined in a `data-info.yaml` file and which is automatically deployed to Styx in the last step of a Tingle pipeline.

In [Backstage](https://backstage.spotify.net/), use the **Search** field to find your workflow.

On the **Overview** tab, click **ENABLE WORKFLOW** button to run the workflow according to its schedule.

Your workflow runs when the next upcoming trigger time comes (for example, 2018-04-25T00, if you deployed a daily pipeline on 2018-04-24).

You can manually trigger a workflow instance immediately by going to the **Instances** tab and clicking the **TRIGGER WORKFLOW** button. You can also trigger a workflow using the Styx command line tool:

```
styx trigger <component-id> <WorkflowId> <parameter>
```

for example:

```
styx trigger magru-demo demoworkflow '2018-04-24'
```

To see events happening to the run of your pipeline use:

```
styx events <component-id> <WorkflowId> <parameter>
```

Click the workflow ID to view more details about a workflow. The **Overview** tab shows you basic information about the current configuration and state of the workflow.

On the **Instances** tab for the workflow, you can see the status of the executions of different partitions. Here you can also access the logs of each execution or see the current progress of the workflow tasks:

Note

At the time of writing, only the partition of 2018-10-31 is available in Hades for the required inputs (`di.golden.path.EndContentFactXT2`, `track_entity` table) of the workflow. So if you trigger or backfill other dates, the workflow instances will fail with a missing dependency error.

Note

After a successful run, you will have an output published in Hades, and subsequent pipeline executions will immediately succeed after the existence check (that is, Luigi won’t run the tasks anew). Whenever you want to rerun a pipeline, you must remove existing output first, in this case by unpublishing the existing output revision(s) from Hades:

```
console $ hades ls <data endpoint> <partition> $ hades unpublish <data endpoint> <partition> <revision id>
```

### Troubleshooting

You get support for all your development and production systems on [Slack](https://spotify.slack.com/).

You'll find multiple users in each channel and there should be someone who can help, no matter how small the problem. Never be afraid to ask.

If you get stuck when doing this tutorial, highlight the applicable text and click **Give feedback** to create an issue. Paste in any error messages you got. If you find the solution, add that too. Help us improve the tutorial for everyone else.

### Troubleshooting GHE and Artifactory

If you get SERVFAIL when trying to connect to GHE, you probably have a problem with your DNS settings. On Mac, check /etc/resolv.conf - it should contain a DNS server that is not a Google one. Either fix this manually in network settings, or use the Fortigate VPN client.

Slack channels for support:

[#it](https://spotify.slack.com/messages/it) for GHE

[#client-build](https://spotify.slack.com/messages/client-build) for Artifactory

### Troubleshooting VPN connections

If you are trying to reach the Spotify Private Network remotely, make sure to start the **FortiClient** application that you installed *when you followed the instructions here:* [Configuring Your Local Development Environment](https://backstage.spotify.net/docs/data-engineering-golden-path/part-1-configuring-your-local-development-environment/1-introduction/). (If you try to use the OS X client, you need to manually configure your DNS settings every time you try to connect to the VPN.)

### Troubleshooting Tingle

[#tingle-users]

### Troubleshooting Docker

If your first build of the Docker package fails, try to rebuild. Otherwise, for help with these systems:

[#docker](https://spotify.slack.com/messages/docker/)

### Troubleshooting Datamon and PagerDuty

For help with these systems:

[#data-support

### Troubleshooting Styx

[#data-support]