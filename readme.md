# Ansible AWX Install
Rudimentary ansible playbook to install AWX. Please read through the playbook and update things accordingly. Nothing is variablized yet so look for things like passwords, usernames.

## Usage
Set up can be bootstrapped using *prep-awx-centos7-setup.sh*. This will install git and ansible and preload the git repository for you. The raw URL for this script can also be passed to GCP as a Meta key for ** startup-script-url ** and the pre-staging will occur on instance deployment

If you use the set up script, once connecting to the instance cd to /root/prep-awx/ and run * ansible-playbook prep-awx.yml * 

Update 02-7-2019: Works in current form, need to break out static assignments of values to variables ie login password/Start replacing bash script with Terraform

Update 01-27-2019: Debugging issue with pre-load data task
