# Ansible AWX Install
Rudimentary ansible playbook to install AWX. Please read through the playbook and update things accordingly. Nothing is variablized yet so look for things like passwords, usernames.

## Usage

**Option 1: Startup Script URL on Compute Instance**

Set up can be bootstrapped using **prep-awx-centos7-setup.sh**. This will install git and ansible and preload the git repository for you. The raw URL for this script can also be passed to GCP as a Meta key for **startup-script-url** and the pre-staging will occur on instance deployment

If you use the set up script, once connecting to the instance cd to **/root/prep-awx/** and run ```ansible-playbook prep-awx.yml```


**Option 2: Let Terraform do it**

For this there is some set up:

1) Create a GCP Service Account with Compute Engine Admin and Compute Engine OS Admin roles
2) Download the json file
3) Edit **./terraform/gcp-vars.tf** and update variables with appropriate values. 
4) Run terraform init to prep your directory with required terraform providers
5) Run terraform plan 
6) Run terraform apply

With this method, terraform will provision the host, then bootstrap the ansible and subsequent playbook for you. This includes opening firewall ports for 80/443/8443. A prepared ssh private keypair is required for this method.

## Updates
Update 02-16-2019: Added terraform for the initial provisioning. Currently has some hard  configured values for the remote_exec provisioner that needs to be cleaned up

Update 02-7-2019: Works in current form, need to break out static assignments of values to variables ie login password/Start replacing bash script with Terraform

Update 01-27-2019: Debugging issue with pre-load data task
