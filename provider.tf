terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.0.0"
    }
  }
  backend "s3" {
      bucket = "my-tf-test-bucket-9121"
      key    = "terraform-statefile"
      region = "ap-south-1"
    }
}

provider "kubernetes" {
  config_path = "~/.kube/config"
}