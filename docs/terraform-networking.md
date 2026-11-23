# Terraform AWS VPC Networking

## Project
AWS-ECOM-001 – ABC E-Commerce Pvt. Ltd.

## Objective
Build a secure, multi-AZ AWS network foundation using Terraform.

## AWS Region
Mumbai (ap-south-1)

## VPC Design

- VPC CIDR: 10.20.0.0/16
- Availability Zones: 2
- Total subnets: 6
- Public subnets: 2
- Private application subnets: 2
- Private database subnets: 2

## Subnet Allocation

| Subnet | CIDR |
|---|---|
| Public AZ 1 | 10.20.1.0/24 |
| Public AZ 2 | 10.20.2.0/24 |
| App AZ 1 | 10.20.11.0/24 |
| App AZ 2 | 10.20.12.0/24 |
| DB AZ 1 | 10.20.21.0/24 |
| DB AZ 2 | 10.20.22.0/24 |

## Routing

- Public route table: Internet Gateway default route.
- Private application route tables: No internet default route currently.
- Private database route tables: No internet default route.
- NAT Gateway: Not deployed to avoid unnecessary cost.

## Security Groups

### ALB Security Group
- Inbound TCP 80 from internet.
- Inbound TCP 443 from internet.

### Application Security Group
- Inbound TCP 8000 from ALB security group.
- Outbound TCP 5432 to database security group.

### Database Security Group
- Inbound TCP 5432 from application security group.

## Terraform Files

- main.tf: Terraform and AWS provider configuration.
- vpc.tf: VPC and subnet resources.
- routes.tf: Route tables and associations.
- security-groups.tf: Security groups and rules.
- outputs.tf: Infrastructure outputs.

## Deployment Commands

Initialize:

    terraform init

Validate:

    terraform validate

Preview:

    terraform plan

Apply:

    terraform apply

Inspect outputs:

    terraform output

## Cost Considerations

This networking foundation does not deploy EC2, NAT Gateway,
Application Load Balancer, EKS, or RDS.

These services are intentionally deferred until required.
AWS pricing and public IPv4 charges should be checked before
adding resources.

## Security Notes

- Database subnets have no direct internet route.
- Application access is restricted to the ALB security group.
- Database access is restricted to the application security group.
- Terraform state and plan files must not be committed to Git.
- Terraform state should be stored securely.

## Current Status

Terraform VPC networking foundation implemented.
Application and database compute resources are separate future stages.
