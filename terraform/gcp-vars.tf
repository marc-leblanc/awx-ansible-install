# Account Setup
variable "gcp_json" {
      default    = "../secrets/gcp_account.json"
}
variable "gcp_project_id" {  
      default    = "lhq-miq-gcp"
}

variable "gcp_region" {
      default  = "northamerica-northeast1"
}

variable "gcp_zone" {
      default   = "a"
}


# Instance Set up
variable "gcp_instance_name" {
      default  = "awx01"

}

variable "gcp_instance_os"{
      default  = "centos-cloud/centos-7"
}
