output "instance_public_ip" {
  description = "Public IP address of the EC2 instance for SSH, Ansible, and API access."
  value       = aws_instance.web_server.public_ip
}

output "instance_public_dns" {
  description = "Public DNS name of the EC2 instance."
  value       = aws_instance.web_server.public_dns
}

output "api_url" {
  description = "API URL using the EC2 public IP and configured API port."
  value       = "http://${aws_instance.web_server.public_ip}:${var.api_port}"
}

output "ssh_command" {
  description = "SSH command template for connecting to the Ubuntu EC2 instance."
  value       = "ssh -i <path-to-private-key> ubuntu@${aws_instance.web_server.public_ip}"
}
