output "instance_id" {
  description = "EC2 instance ID"
  value       = aws_instance.vehicle_api.id
}

output "public_ip" {
  description = "EC2 public IPv4 address"
  value       = aws_instance.vehicle_api.public_ip
}

output "public_dns" {
  description = "EC2 public DNS"
  value       = aws_instance.vehicle_api.public_dns
}