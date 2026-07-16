output "droplet_ip" {
  value = digitalocean_droplet.server.ipv4_address
}

output "ssh_command" {
  value = "ssh -i ./id_ed25519 root@${digitalocean_droplet.server.ipv4_address}"
}