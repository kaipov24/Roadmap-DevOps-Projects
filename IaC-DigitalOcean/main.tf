terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

provider "digitalocean" {}

resource "digitalocean_ssh_key" "terraform" {
  name       = "terraform-key"
  public_key = file(var.ssh_public_key_path)
}

resource "digitalocean_droplet" "server" {
  name     = var.droplet_name
  region   = var.region
  size     = var.droplet_size
  image    = var.droplet_image
  ssh_keys = [digitalocean_ssh_key.terraform.fingerprint]
}