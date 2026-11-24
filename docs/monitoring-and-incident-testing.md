# Monitoring and Incident Testing Report

## Project
AWS-ECOM-001 - ABC E-Commerce Pvt. Ltd.

## 1. Monitoring Architecture

The application is deployed on Amazon EKS.

Monitoring components:
- Prometheus: Collects Kubernetes monitoring metrics.
- Grafana: Visualizes metrics through dashboards.
- Metrics Server: Provides CPU and memory metrics to Kubernetes.
- Node Exporter: Collects worker-node metrics.
- Kube State Metrics: Exposes Kubernetes object and state metrics.

## 2. Monitoring Deployment

Namespace: monitoring

Prometheus:
- Helm chart: prometheus-community/prometheus
- Service: prometheus-server
- Persistent storage: Disabled for this lab.

Grafana:
- Helm chart: grafana/grafana
- Service: ClusterIP
- Dashboard imported: Kubernetes Views Global (Dashboard ID 15757)

Metrics Server:
- Installed in kube-system.
- Verified using kubectl top commands.

## 3. Application Health

Namespace: ecommerce

Expected workloads:
- 2 FastAPI application replicas
- 1 PostgreSQL database pod

Observed status:
- Both API pods: Running
- PostgreSQL pod: Running
- Both EKS worker nodes: Ready

## 4. Resource Monitoring Results

Observed worker-node metrics during testing:

| Worker | CPU Usage | Memory Usage |
|---|---:|---:|
| Worker 1 | 5% | 63% |
| Worker 2 | 3% | 72% |

Observed application pod metrics:

| Component | CPU | Memory |
|---|---:|---:|
| API replica 1 | 2m | 42Mi |
| API replica 2 | 2m | 40Mi |
| PostgreSQL | 9m | 31Mi |

These are point-in-time observations, not performance guarantees.

## 5. Incident Simulation: API Pod Failure

Test objective:
Verify that Kubernetes replaces a failed application pod.

Action:
Deleted one API pod using:

kubectl delete pod ecommerce-api-69f9f954cc-67jw9 -n ecommerce

Observation:
- Kubernetes detected that the Deployment had fewer than its desired two replicas.
- A replacement API pod was created automatically.
- The replacement pod reached Running status.
- The other API replica remained Running.
- PostgreSQL remained Running.

Result: PASS

This verifies Deployment-level pod self-healing.

## 6. Important Limitations

- Alert rules and notification delivery have not yet been configured or tested.
- No production load test has been performed.
- Grafana and Prometheus use non-persistent storage in this lab.
- This setup is a learning environment, not a production availability guarantee.
- Node memory usage should be monitored because the worker instances have limited RAM.

## 7. Verification Commands

kubectl get nodes
kubectl get pods -n ecommerce
kubectl get pods -n monitoring
kubectl top nodes
kubectl top pods -n ecommerce

## 8. Conclusion

The EKS application deployment, Kubernetes monitoring stack, resource metrics,
and API pod self-healing behavior were verified successfully.

Alerting, production hardening, and final infrastructure cleanup remain pending.
EOFcd ~/projects/aws-ecom-001

cat > docs/monitoring-and-incident-testing.md <<'EOF'
# Monitoring and Incident Testing Report

## Project
AWS-ECOM-001 - ABC E-Commerce Pvt. Ltd.

## 1. Monitoring Architecture

The application is deployed on Amazon EKS.

Monitoring components:
- Prometheus: Collects Kubernetes monitoring metrics.
- Grafana: Visualizes metrics through dashboards.
- Metrics Server: Provides CPU and memory metrics to Kubernetes.
- Node Exporter: Collects worker-node metrics.
- Kube State Metrics: Exposes Kubernetes object and state metrics.

## 2. Monitoring Deployment

Namespace: monitoring

Prometheus:
- Helm chart: prometheus-community/prometheus
- Service: prometheus-server
- Persistent storage: Disabled for this lab.

Grafana:
- Helm chart: grafana/grafana
- Service: ClusterIP
- Dashboard imported: Kubernetes Views Global (Dashboard ID 15757)

Metrics Server:
- Installed in kube-system.
- Verified using kubectl top commands.

## 3. Application Health

Namespace: ecommerce

Expected workloads:
- 2 FastAPI application replicas
- 1 PostgreSQL database pod

Observed status:
- Both API pods: Running
- PostgreSQL pod: Running
- Both EKS worker nodes: Ready

## 4. Resource Monitoring Results

Observed worker-node metrics during testing:

| Worker | CPU Usage | Memory Usage |
|---|---:|---:|
| Worker 1 | 5% | 63% |
| Worker 2 | 3% | 72% |

Observed application pod metrics:

| Component | CPU | Memory |
|---|---:|---:|
| API replica 1 | 2m | 42Mi |
| API replica 2 | 2m | 40Mi |
| PostgreSQL | 9m | 31Mi |

These are point-in-time observations, not performance guarantees.

## 5. Incident Simulation: API Pod Failure

Test objective:
Verify that Kubernetes replaces a failed application pod.

Action:
Deleted one API pod using:

kubectl delete pod ecommerce-api-69f9f954cc-67jw9 -n ecommerce

Observation:
- Kubernetes detected that the Deployment had fewer than its desired two replicas.
- A replacement API pod was created automatically.
- The replacement pod reached Running status.
- The other API replica remained Running.
- PostgreSQL remained Running.

Result: PASS

This verifies Deployment-level pod self-healing.

## 6. Important Limitations

- Alert rules and notification delivery have not yet been configured or tested.
- No production load test has been performed.
- Grafana and Prometheus use non-persistent storage in this lab.
- This setup is a learning environment, not a production availability guarantee.
- Node memory usage should be monitored because the worker instances have limited RAM.

## 7. Verification Commands

kubectl get nodes
kubectl get pods -n ecommerce
kubectl get pods -n monitoring
kubectl top nodes
kubectl top pods -n ecommerce

## 8. Conclusion

The EKS application deployment, Kubernetes monitoring stack, resource metrics,
and API pod self-healing behavior were verified successfully.

Alerting, production hardening, and final infrastructure cleanup remain pending.
