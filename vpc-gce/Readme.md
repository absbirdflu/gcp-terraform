## Before you begion
1. Create a project in the Google Cloud Console and set up billing on that project.
2. Install [Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli?_ga=2.236219975.750382409.1633530418-1893233004.1631609996) and [Cloud SDK](https://cloud.google.com/sdk/docs/install) on your PC or Laptop.
3. If you don't want to install on your PC or Laptop, you can use [Cloud Shell](https://cloud.google.com/shell), Terraform is integrated with Cloud Shell, and Cloud Shell automatically authenticates Terraform, letting you get started with less set up. To learn more, see the [Kickstart Terraform on GCP with Google Cloud Shell](https://www.hashicorp.com/blog/kickstart-terraform-on-gcp-with-google-cloud-shell/) blog.


## Prepare variables and authenticate with GCP
1. Authenticate with GCP. The easiest way to do this is to run ```gcloud auth application-default login```
2. Modify ```variables.tf``` and you'll want to include the following configuration:
* The ```project_id``` field should be your GCP project id. The project indicates the default GCP project all of your resources will be created in. 
* The ```region``` and ```zone``` are locations for your resources to be created in.
* The ```ip_range``` is for your subnetwork IP range.

## With a Terraform config and with your credentials configured, it's time to provision your resources:
1. terraform init
2. terraform plan
3. terraform destroy