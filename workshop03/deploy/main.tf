terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "3.0.2"
    }
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "2.26.0"
    }
    local = {
      source  = "hashicorp/local"
      version = "2.4.0"
    }
  }

  backend "s3" {
    endpoint                    = "https://sgp1.digitaloceanspaces.com"
    region                      = "sgp1"
    key                         = "workshop03/terraform.tfstate"
    skip_credentials_validation = true
    skip_region_validation      = true
    skip_metadata_api_check     = true
  }
}

provider "docker" {
  host = var.docker_host
}

provider "digitalocean" {
  token = var.do_token
}

provider "local" {}