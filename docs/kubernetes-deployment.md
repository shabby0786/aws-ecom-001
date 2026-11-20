# Kubernetes Deployment - ABC E-Commerce

## Environment

- Platform: Docker Desktop Kubernetes
- Cluster: docker-desktop
- Namespace: ecommerce
- Container Runtime: containerd
- Application: FastAPI
- Database: PostgreSQL 16

## Kubernetes Resources

| Resource | Name | Configuration |
|---|---|---|
| Namespace | ecommerce | Application isolation |
| API Deployment | ecommerce-api | 2 replicas |
| Database Deployment | ecommerce-db | 1 replica |
| API Service | ecommerce-api | ClusterIP, port 80 |
| Database Service | db | ClusterIP, port 5432 |
| PVC | ecommerce-db-pvc | 1Gi, ReadWriteOnce |
| Secret | ecommerce-db-secret | Database password |

## Application Architecture

Client
  |
  v
Kubernetes API Service
  |
  v
Two FastAPI Pods
  |
  v
PostgreSQL Service (db)
  |
  v
PostgreSQL Pod
  |
  v
PersistentVolumeClaim

## Application Access

Local port-forward:

kubectl port-forward svc/ecommerce-api 8002:80 -n ecommerce

Swagger UI:

http://localhost:8002/docs

Health endpoint:

http://localhost:8002/health

## Deployment Commands

Apply database storage:

kubectl apply -f infrastructure/kubernetes/postgres-pvc.yaml

Deploy PostgreSQL:

kubectl apply -f infrastructure/kubernetes/postgres.yaml

Create database Service:

kubectl apply -f infrastructure/kubernetes/postgres-service.yaml

Deploy application:

kubectl apply -f infrastructure/kubernetes/deployment.yaml

Create application Service:

kubectl apply -f infrastructure/kubernetes/service.yaml

## Verification Commands

kubectl get all,pvc -n ecommerce

kubectl get endpoints -n ecommerce

kubectl logs deployment/ecommerce-api -n ecommerce

kubectl logs deployment/ecommerce-db -n ecommerce

## Self-Healing Test

Delete one API Pod:

kubectl delete pod POD_NAME -n ecommerce

The Deployment's ReplicaSet automatically creates a replacement Pod to maintain the desired replica count.

## Important Limitations

- This is a local, single-node Kubernetes environment.
- It is not a production EKS deployment.
- PostgreSQL runs as a single replica.
- Local-path storage is not production-grade shared storage.
- No production ingress, TLS, autoscaling, monitoring or backup configuration has been implemented yet.
- Database credentials are for local development only.

## Current Validation

- API replicas: 2/2 Ready
- PostgreSQL: 1/1 Ready
- API Service endpoints: 2
- Database Service endpoint: 1
- PVC: Bound
- Pod self-healing: Verified
