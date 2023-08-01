terraform {
  required_providers {
    cloudflare = {
      source = "cloudflare/cloudflare"
      version = "4.7.1"
    }
    random = {
      source = "hashicorp/random"
      version = "3.5.1"
    }
  }
}
