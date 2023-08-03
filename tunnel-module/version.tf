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
    local = {
      source = "hashicorp/local"
      version = "2.4.0"
    }
    null = {
      source = "hashicorp/null"
      version = "3.2.1"
    }
  }
}
