module "gcp" {
   source                 = "./modules/gcp"
 #  gcp_json               = "/home/mleblanc/projects/gwo-auto/secrets/gcp.json"
   gcp_project_id         = "phil-test-252017"
   gcp_region             = "northamerica-northeast1"
   gcp_zone               = "a"
   gcp_instance_name      = "portal01"
   gcp_instance_os        = "centos-cloud/centos-7"
   #ssh_key_path           = "~/.ssh/"
   #ssh_key_pub            = "gcp_rsa.pub"
   #ssh_key_priv           = "gcp_rsa"
   ssh_user               = "mleblanc"
   ansible_playbook       = "gwo-auto.yml"
   github_repo            = "https://github.com/marc-leblanc/awx-ansible-install.git"
}

# source             = module path
# gcp_jason          = GCP Service Account Key 
# gcp_project_id     = GCP Project ID
# gcp_region         = GCP Region for instances ie northamerica-northeast
# gcp_zone           = GCP Zone within the region ie a,b,c
# gcp_instance_name  = The instance name as it will appear in GCP https://cloud.google.com/compute/docs/regions-zones/
# gcp_instance_os    = The OS Image to use - public images https://cloud.google.com/compute/docs/images#os-compute-support
# ssh_key_path       = Path to SSH key pair to use
# ssh_key_pub        = Public Key filename to be provisioned to the instance
# ssh_key_priv       = Private Key filename 
# ssh_user           = Username for ssh
