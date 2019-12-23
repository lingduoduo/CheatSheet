####  gcloud tools

Responsible for cloud authentication, configuration, and other interactions on GCP

```shell
-- begin authorization and config of the cloud SDK
gcloud init

-- show accounts with GCP credentials and indicates which account configuration is currently active
gcloud auth list

-- list existing cloud SDK
gcloud config configurations list

-- activate config account
gcloud config configuration activate lingh@spotify.com
```

####  gsutil tools

Responsible for interacting with Google Cloud Storage buckets and objects

```shell
-- create a bucket
gsutil mb gs://lingh

-- list bucket on GCP project
gsutil ls gs://lingh

-- copy file or local directory to GCP bucket
gsutil cp -r /Users/ling/Desktop/Git/sample.txt gs://lingh
gsutil cp -r /Users/ling/Desktop/Git/sample.txt gs://lingh

-- remove file or directory on GCP bucket
gsutil rm -r gs://lingh/sample.txt
gsutil rm -r gs://lingh/

-- provision a VM instance
gcloud compute instance create -help
gcloud compute instance create sample-instance-lingh

-- list a VM instance
gcloud compute instance list

-- contect to a VM instance
gcloud compute ssh sample-instance-lingh

-- delete a VM instance
gcloud compute instance delete sample-instance-lingh
```

####  bq tools

Responsible for interacting and mangaging Google BigQuery via the command line

```shell

```



####  Kubectl tools

Responsible for managing Kubernetes container clusters on GCP