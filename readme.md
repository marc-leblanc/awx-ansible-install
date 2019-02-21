# AWX Install in GCP using Terraform and Ansible 

This repo can be used to deploy AWX within GCP. Provisioning of the Compute Engine VM Instance is handled by Terraform. Terraform also bootstraps the install of Git and Ansible and then kicks off the playbook run to install and configure AWX. 


**IMPORTANT NOTE:** Password for admin is currently hard coded into they the *pre-awx.yml* file on line 57. Update accordingly. This will likely be variablized in the future. 

## Usage

**Option 1: Startup Script URL on Compute Instance**

Set up can be bootstrapped using **prep-awx-centos7-setup.sh**. This will install git and ansible and preload the git repository for you. The raw URL for this script can also be passed to GCP as a Meta key for **startup-script-url** and the pre-staging will occur on instance deployment

If you use the set up script, once connecting to the instance cd to **/root/prep-awx/** and run ```ansible-playbook prep-awx.yml```


**Option 2: Let Terraform do it**

For this there is some set up:

1) Create a GCP Service Account with Compute Engine Admin and Compute Engine OS Admin roles
2) Download the json file
3) Edit **./terraform/main.tf** and update variables with appropriate values. 
4) Run terraform init to prep your directory with required terraform providers
5) Run terraform plan 
6) Run terraform apply

With this method, terraform will provision the host, then bootstrap the ansible and subsequent playbook for you. This includes opening firewall ports for 80/443/8443. A prepared ssh private keypair is required for this method.

## Tear Down
To bring the instance down, simply run ```terraform destroy``` 

## Updates
Update 02-21-2019: Set up terraform to run the gcp provisioner as a module. Cleaner variable set up in main.tf. Cleaned out some static set up within the terraform and variablized 

Update 02-16-2019: Added terraform for the initial provisioning. Currently has some hard  configured values for the remote_exec provisioner that needs to be cleaned up

Update 02-7-2019: Works in current form, need to break out static assignments of values to variables ie login password/Start replacing bash script with Terraform

Update 01-27-2019: Debugging issue with pre-load data task
