module "gcp" {
   source                 = "./modules/gcp"
   awx_admin              = "admin"
   awx_admin_pass         = "supersecretpassword"
   gcp_json               = "~/projects/awx-ansible-setup/secrets/mleblanc-ce-prov.json"
   gcp_project_id         = "solar-cab-231515"
   gcp_region             = "northamerica-northeast1"
   gcp_zone               = "a"
   gcp_instance_name      = "awx01"
   gcp_instance_os        = "centos-cloud/centos-7"
   ssh_key_path           = "~/.ssh/"
   ssh_key_pub            = "gcp_rsa.pub"
   ssh_key_priv           = "gcp_rsa"
   ssh_user               = "mleblanc"
}

# source             = module path. Do not Change
# gcp_json           = GCP Service Account Key (path + filename) 
# gcp_project_id     = GCP Project ID
# gcp_region         = GCP Region for instances ie northamerica-northeast
# gcp_zone           = GCP Zone within the region ie a,b,c
# gcp_instance_name  = The instance name as it will appear in GCP https://cloud.google.com/compute/docs/regions-zones/
# gcp_instance_os    = The OS Image to use - public images https://cloud.google.com/compute/docs/images#os-compute-support
# ssh_key_path       = Path to SSH key pair to use
# ssh_key_pub        = Public Key filename to be provisioned to the instance
# ssh_key_priv       = Private Key filename 
# ssh_user           = Username for ssh
