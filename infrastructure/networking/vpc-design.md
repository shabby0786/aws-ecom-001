
# AWS-ECOM-001: VPC Network Design

## 1. Project Information

- Project ID: AWS-ECOM-001
- Client: ABC E-Commerce Pvt. Ltd.
- Document: Proposed VPC Network Design
- Status: Draft - Pending Review and Approval

## 2. Network Objective

Design a secure, scalable and highly available AWS network for hosting the e-commerce application.

The network will separate public-facing infrastructure, application workloads and database workloads.

## 3. VPC Configuration

- VPC Name: aws-ecom-prod-vpc
- IPv4 CIDR: 10.20.0.0/16
- Total IPv4 Addresses: 65,536
- DNS Resolution: Enabled (proposed)
- DNS Hostnames: Enabled (proposed)

## 4. Availability Zones

The proposed architecture uses two Availability Zones for improved availability.

- Availability Zone A
- Availability Zone B

Actual AZ IDs will be selected during deployment.

## 5. Subnet Design

### Availability Zone A

| Subnet | CIDR | Type |
|---|---|---|
| Public-A | 10.20.1.0/24 | Public |
| App-A | 10.20.11.0/24 | Private |
| DB-A | 10.20.21.0/24 | Private |

### Availability Zone B

| Subnet | CIDR | Type |
|---|---|---|
| Public-B | 10.20.2.0/24 | Public |
| App-B | 10.20.12.0/24 | Private |
| DB-B | 10.20.22.0/24 | Private |

## 6. Routing Design

### Public Subnets

- VPC local route.
- Default route (0.0.0.0/0) to Internet Gateway.

### Private Application Subnets

- VPC local route.
- Outbound internet access through NAT Gateway, if required.
- No direct inbound internet route.

### Private Database Subnets

- VPC local route.
- No direct internet route.
- Database access restricted to authorized application workloads.

## 7. Security Design

- Application and database resources will not receive unnecessary public IP addresses.
- Security Groups will follow least-privilege principles.
- Database access will be limited to the application tier.
- Administrative access will use secure, approved methods.
- Network ACLs will provide an additional subnet-level control where appropriate.

## 8. High Availability

- Deploy workloads across two Availability Zones where supported.
- Application traffic will be distributed through an Application Load Balancer.
- Database high availability strategy will be finalized according to client requirements and budget.

## 9. Cost Considerations

Potential AWS charges include:

- NAT Gateway hourly and data processing charges.
- Application Load Balancer charges.
- Data transfer charges.
- Other deployed networking resources.

Resource sizing and deployment will require client approval.

## 10. Pending Decisions

- Final traffic and IP capacity requirements.
- EKS pod networking and subnet IP capacity.
- NAT Gateway architecture and cost approval.
- Database availability and recovery requirements.
- Final Availability Zone selection.
- Client approval of the proposed CIDR ranges.

## 11. Approval Status

Draft only. No AWS resources have been created.

Final implementation requires architecture review and client approval.

