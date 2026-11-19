# Project 01: AWS Solution Architecture

**Project ID:** AWS-ECOM-001  
**Client:** ABC E-Commerce Pvt. Ltd.  
**Document Type:** Proposed Solution Architecture  
**Version:** 1.0  
**Status:** Initial Proposal — Pending Client Confirmation

## 1. Architecture Objective

Design a secure, scalable and maintainable AWS hosting architecture for the ABC E-Commerce application.

The design aims to reduce single points of failure, support application scaling, improve deployment reliability and provide monitoring and recovery capabilities.

## 2. Proposed Architecture Components

### 2.1 DNS — Amazon Route 53
- Manage the application domain and DNS records.
- Route customer requests to the application delivery layer.

### 2.2 Content Delivery — Amazon CloudFront
- Deliver static website content through edge locations.
- Improve content delivery performance.
- Use HTTPS for secure communication.

### 2.3 Application Entry — Application Load Balancer
- Receive incoming HTTP/HTTPS traffic.
- Forward requests to healthy application targets.
- Integrate with Kubernetes ingress routing.

### 2.4 Network — Amazon VPC
- Create an isolated AWS network.
- Use public and private subnets across multiple Availability Zones, subject to final availability and cost requirements.
- Keep application workloads and database resources in private subnets where appropriate.
- Configure routing, security groups and controlled internet access.

### 2.5 Container Orchestration — Amazon EKS
- Run the Dockerized application on Kubernetes.
- Manage application pods and deployments.
- Configure health checks and horizontal scaling where justified.

### 2.6 Container Registry — Amazon ECR
- Store application Docker images.
- Provide images for Kubernetes deployments.

### 2.7 Database — Amazon RDS PostgreSQL
- Store application data.
- Keep database access restricted to authorized application workloads.
- Configure backups and recovery based on confirmed RPO and retention requirements.

### 2.8 Object Storage — Amazon S3
- Store product images and uploaded files.
- Apply suitable access controls and lifecycle policies.

### 2.9 Monitoring — Amazon CloudWatch
- Collect infrastructure and application logs.
- Configure metrics, dashboards and alerts.

## 3. Request Flow

1. Customer opens the e-commerce website.
2. Route 53 resolves the application domain.
3. CloudFront delivers cached static content where appropriate.
4. Dynamic requests reach the Application Load Balancer.
5. ALB forwards requests through Kubernetes ingress routing.
6. EKS application pods process the requests.
7. Application pods communicate with RDS PostgreSQL.
8. Product images and uploaded files are accessed through S3.

## 4. Security Design Principles

- Apply least-privilege IAM permissions.
- Avoid exposing database resources directly to the public internet.
- Restrict network access through security groups.
- Use HTTPS for application communication.
- Protect secrets using an appropriate secrets-management solution.
- Enable appropriate audit logging.
- Encrypt data at rest and in transit where applicable.

## 5. High Availability and Recovery

The proposed design will evaluate:
- Multiple Availability Zones.
- Application replica management.
- Load balancer health checks.
- Database backup and recovery.
- Application deployment rollback.
- Infrastructure and application monitoring.

Availability targets, RTO and RPO must be confirmed with the client before implementation.

## 6. Cost Considerations

Potential AWS costs include:
- EKS cluster and worker compute.
- EC2 instances or other compute capacity.
- NAT Gateway.
- Application Load Balancer.
- RDS database.
- EBS and S3 storage.
- CloudWatch logs and metrics.
- Data transfer and CloudFront usage.

No paid AWS resources will be created until the architecture, budget and deployment plan are reviewed and explicitly approved.

## 7. Pending Client Decisions

- Expected peak traffic and concurrent users.
- Required Availability Zones and availability target.
- Monthly infrastructure budget.
- RTO and RPO.
- Database size and growth expectations.
- Data retention and compliance requirements.
- Domain and certificate arrangements.
- Support and maintenance expectations.

## 8. Architecture Status

Initial proposed architecture documented.

Final architecture approval and capacity planning are pending client requirement confirmation.
