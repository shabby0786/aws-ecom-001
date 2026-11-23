
output "vpc_id" {
  description = "ID of the project VPC"
  value       = aws_vpc.main.id
}

output "vpc_cidr" {
  description = "VPC IPv4 CIDR"
  value       = aws_vpc.main.cidr_block
}

output "availability_zones" {
  description = "Selected AWS Availability Zones"
  value       = local.availability_zones
}

output "public_subnet_ids" {
  description = "Public subnet IDs"
  value = {
    for key, subnet in aws_subnet.public : key => subnet.id
  }
}

output "private_app_subnet_ids" {
  description = "Private application subnet IDs"
  value = {
    for key, subnet in aws_subnet.private_app : key => subnet.id
  }
}

output "private_db_subnet_ids" {
  description = "Private database subnet IDs"
  value = {
    for key, subnet in aws_subnet.private_db : key => subnet.id
  }
}

output "security_group_ids" {
  description = "Project security group IDs"
  value = {
    alb      = aws_security_group.alb.id
    app      = aws_security_group.app.id
    database = aws_security_group.database.id
  }
}
