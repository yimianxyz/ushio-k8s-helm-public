# Ushio K8s Helm - Public Demo Branch

This is a **sanitized version** of the private [Ushio Kubernetes Infrastructure project](https://github.com/yimianxyz/ushio-k8s-helm) with all sensitive information masked for public demonstration and learning purposes.

### 🏗️ **Core Infrastructure Components:**

- **🌐 Multi-region VPN services** (V2Ray USA/China endpoints with intelligent routing)
- **🔄 Reverse proxy services** (FRP for NAT traversal and internal service exposure)
- **📱 Static website hosting** (15+ domains with automated SSL/TLS)
- **📊 Complete monitoring stack** (Prometheus + Grafana + Node Exporter)
- **📝 Centralized logging** (ELK stack: Elasticsearch + Logstash + Kibana)
- **🔄 CI/CD pipeline** (Drone CI with Kubernetes runners)
- **🔐 Automated certificate management** (Let's Encrypt + DNSPod webhook)
- **📨 Message queue infrastructure** (Apache Kafka for log streaming)
- **⚖️ Load balancing** (NGINX Ingress Controller)
- **🔧 Service mesh** (Internal service discovery and routing)

## 📁 Branch Structure & Evolution

This project demonstrates **two distinct Kubernetes cluster configurations**, each serving different operational needs:

### 1. **`main` Branch - Production Kubernetes Cluster**
- **Purpose**: Production-ready infrastructure for serving real users
- **Cluster Configuration**: Multi-region deployment (USA/China) with geo-routing
- **Services**: 15+ static websites, full VPN infrastructure, monitoring
- **Complexity**: Enterprise-grade with advanced routing and load balancing
- **Hosting Requirements**: **Public IP required** - Recommended on cloud-based instances (AWS EC2, GCP Compute Engine, DigitalOcean Droplets) for reliable internet connectivity and global accessibility
- **Hardware**: Cloud VPS with guaranteed uptime and bandwidth

### 2. **`homi` Branch - Development Kubernetes Cluster**
- **Purpose**: Development-focused environment with full CI/CD pipeline
- **Cluster Configuration**: Single-region with comprehensive logging and CI/CD
- **Services**: Drone CI, complete ELK stack, development tooling
- **Complexity**: Development-optimized with extensive logging and debugging
- **Hosting Requirements**: **Self-hosted physical machines** - Designed for repurposed old laptops/desktops with large storage capacity for logs and persistent data
- **Hardware**: Modified physical machines with high-capacity storage (500GB+ for logs and artifacts)


## Masked Information

For security reasons, the following information has been **masked**:

- ✅ **Domain names preserved**: `yimian.xyz`, `iotcat.me`, `eee.dog`
- ❌ **V2Ray client UUIDs**: Replaced with `xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx`
- ❌ **FRP tokens**: Replaced with comments for manual configuration
- ❌ **Secret keys**: Replaced with comments for manual configuration
- ❌ **User emails**: Replaced with `user1`, `user2`, etc.
- ❌ **Authentication credentials**: Base64 encoded placeholders  
- ❌ **File paths**: Replaced with `/path/to/*/data`
- ❌ **Join commands**: Replaced with `[MASKED_JOIN_COMMAND]`

## 🏛️ Architecture Overview

### **High-Level System Architecture**

```
                         ┌─────────────────────────────────────────┐
                         │              Internet                   │
                         │          (Global Traffic)               │
                         └─────────────────┬───────────────────────┘
                                          │
                    ┌─────────────────────▼───────────────────────┐
                    │             Load Balancer                   │
                    │         (NGINX Ingress Controller)          │
                    │    • SSL/TLS Termination                   │
                    │    • Path-based Routing                    │
                    │    • Rate Limiting                         │
                    └─────────────────────┬───────────────────────┘
                                          │
             ┌────────────────────────────┼────────────────────────────┐
             │                            │                            │
    ┌────────▼────────┐        ┌─────────▼─────────┐        ┌─────────▼─────────┐
    │   Static Sites  │        │      V2Ray        │        │       FRP         │
    │  (15+ domains)  │        │   (VPN/Proxy)     │        │  (Reverse Proxy)  │
    │                 │        │                   │        │                   │
    │ • GitHub Pages  │        │ • USA Endpoint    │        │ • NAT Traversal   │
    │ • Custom Domains│        │ • China Endpoint  │        │ • SSH Tunneling   │
    │ • Auto SSL/TLS  │        │ • Smart Routing   │        │ • Service Exposure│
    └─────────────────┘        └───────────────────┘        └───────────────────┘
                                          │
             ┌────────────────────────────┼────────────────────────────┐
             │                            │                            │
    ┌────────▼────────┐        ┌─────────▼─────────┐        ┌─────────▼─────────┐
    │   Monitoring    │        │     Logging       │        │      CI/CD        │
    │                 │        │   (ELK Stack)     │        │   (Drone CI)      │
    │ • Prometheus    │        │                   │        │                   │
    │ • Grafana       │        │ • Elasticsearch   │        │ • Build Pipelines │
    │ • Node Exporter │        │ • Logstash        │        │ • K8s Runners     │
    │ • Alertmanager  │        │ • Kibana          │        │ • Artifact Storage│
    └─────────────────┘        └───────────────────┘        └───────────────────┘
```

### **Network Flow & Data Plane**

```
┌─────────────────────────────────────────────────────────────────────────────────┐
│                              Data Flow Architecture                             │
└─────────────────────────────────────────────────────────────────────────────────┘

    User Request                    SSL/TLS               Load Balancing
         │                       Termination                    │
         ▼                           │                          ▼
┌─────────────────┐           ┌─────────▼─────────┐    ┌─────────────────┐
│   Client        │  HTTPS    │  Ingress-Nginx   │    │   Backend       │
│  (Browser/App)  │ ────────► │   Controller      │───►│   Services      │
└─────────────────┘           └───────────────────┘    └─────────────────┘
                                       │
                              ┌────────▼────────┐
                              │  Certificate    │
                              │   Management    │
                              │ (cert-manager)  │
                              └─────────────────┘
                                       │
                              ┌────────▼────────┐
                              │   DNSPod API    │
                              │ (DNS Challenge) │
                              └─────────────────┘
```

### **Service Mesh & Internal Communication**

```
┌─────────────────────────────────────────────────────────────────────────────────┐
│                         Internal Service Communication                          │
└─────────────────────────────────────────────────────────────────────────────────┘

                          ┌─────────────────────────────────────────┐
                          │              NGINX Ingress              │
                          │         (Traffic Distribution)          │
                          └─────────────────┬───────────────────────┘
                                           │
                   ┌───────────────────────┼───────────────────────┐
                   │                       │                       │
                   ▼                       ▼                       ▼
            ┌─────────────┐         ┌─────────────┐         ┌─────────────┐
            │   V2Ray     │         │ Static Sites│         │   Grafana   │
            │   Services  │         │  (Websites) │         │  Dashboard  │
            └─────────────┘         └─────────────┘         └──────┬──────┘
                                                                   │
                                                                   │ queries
                                                                   ▼
    ┌─────────────────────────────────────────────────────────────────────────────────┐
    │                              MONITORING STACK                                   │
    │                                                                                 │
    │  ┌─────────────┐    scrapes    ┌─────────────┐    scrapes    ┌─────────────┐   │
    │  │ Prometheus  │◄──────────────│Node Exporter│               │Kube-State   │   │
    │  │   (Metrics) │               │  (Metrics)  │               │  Metrics    │   │
    │  └─────────────┘               └─────────────┘               └──────┬──────┘   │
    │         ▲                                                           │          │
    │         │ scrapes                                         scrapes   │          │
    │         └─────────────────────────────────────────────────────────────┘          │
    └─────────────────────────────────────────────────────────────────────────────────┘

    ┌─────────────────────────────────────────────────────────────────────────────────┐
    │                               LOGGING STACK                                     │
    │                                                                                 │
    │  ┌─────────────┐    ships to   ┌─────────────┐   processes   ┌─────────────┐   │
    │  │  Filebeat   │──────────────►│  Logstash   │──────────────►│Elasticsearch│   │
    │  │(Log Shipper)│               │(Log Processor)│               │(Log Storage)│   │
    │  └─────────────┘               └─────────────┘               └──────┬──────┘   │
    │         ▲                              ▲                           │          │
    │         │ collects logs                │ optional buffer           │ queries  │
    │         │                              │                           ▼          │
    │  ┌─────────────┐                ┌─────────────┐                ┌─────────────┐   │
    │  │   Pods &    │                │    Kafka    │                │   Kibana    │   │
    │  │ Containers  │                │ (Message Q) │                │(Log Viewer) │   │
    │  └─────────────┘                └─────────────┘                └─────────────┘   │
    └─────────────────────────────────────────────────────────────────────────────────┘

    ┌─────────────────────────────────────────────────────────────────────────────────┐
    │                               CI/CD STACK                                       │
    │                                                                                 │
    │  ┌─────────────┐    creates    ┌─────────────┐    executes    ┌─────────────┐   │
    │  │  Drone CI   │──────────────►│ Kubernetes  │──────────────►│  Build      │   │
    │  │  (Server)   │               │  Runners    │               │  Pods       │   │
    │  └─────────────┘               └─────────────┘               └─────────────┘   │
    │         ▲                              │                           │          │
    │         │ stores artifacts             │ uses                      │ writes   │
    │         │                              ▼                           ▼          │
    │  ┌─────────────┐                ┌─────────────┐                ┌─────────────┐   │
    │  │ Persistent  │                │ Kubernetes  │                │   Logs &    │   │
    │  │  Storage    │                │    API      │                │  Artifacts  │   │
    │  └─────────────┘                └─────────────┘                └─────────────┘   │
    └─────────────────────────────────────────────────────────────────────────────────┘

    ┌─────────────────────────────────────────────────────────────────────────────────┐
    │                           REVERSE PROXY (FRP)                                  │
    │                                                                                 │
    │  ┌─────────────┐   UDP/TCP     ┌─────────────┐   tunnels to   ┌─────────────┐   │
    │  │ FRP Client  │◄─────────────►│ FRP Server  │◄──────────────►│ External    │   │
    │  │ (Internal)  │               │ (Public)    │               │ Services    │   │
    │  └─────────────┘               └─────────────┘               └─────────────┘   │
    │         ▲                              │                           │          │
    │         │ connects to                  │ exposes                   │ accesses │
    │         │                              ▼                           ▼          │
    │  ┌─────────────┐                ┌─────────────┐                ┌─────────────┐   │
    │  │  Internal   │                │  NodePort   │                │  External   │   │
    │  │  Services   │                │  Services   │                │   Users     │   │
    │  └─────────────┘                └─────────────┘                └─────────────┘   │
    └─────────────────────────────────────────────────────────────────────────────────┘
```

## 🚀 Quick Start

### **Prerequisites Checklist**
- [ ] Kubernetes cluster (v1.23.3+) with nodes labeled appropriately
- [ ] Helm 3.0+ installed and configured
- [ ] kubectl configured with cluster admin access
- [ ] DNS provider configured (for certificate management)
- [ ] Storage provisioner available (for persistent volumes)

### **Deployment Steps**

1. **📋 Infrastructure Setup** (follow `setup.md` for detailed guide)
   ```bash
   # Clone and navigate to the repository
   git clone <repository-url>
   cd ushio-k8s-helm
   git checkout public-demo
   ```

2. **🔧 Configuration Review**
   ```bash
   # Review and customize configuration files
   vim init.sh                    # Main deployment script
   vim cert-manager/*.yaml        # Certificate configurations
   vim static-sites/*.yaml        # Website configurations
   ```

3. **🚀 Deploy Services**
   ```bash
   # Make deployment script executable
   chmod +x init.sh
   
   # Deploy all services (takes 10-15 minutes)
   ./init.sh
   ```

4. **✅ Verify Deployment**
   ```bash
   # Check all namespaces
   kubectl get namespaces
   
   # Check service status
   kubectl get pods --all-namespaces
   kubectl get ingress --all-namespaces
   kubectl get certificates --all-namespaces
   ```

### **Post-Deployment Verification**

```bash
# Check ingress controller
kubectl get pods -n ingress -l app.kubernetes.io/name=ingress-nginx

# Check certificate status
kubectl get certificates -n static-sites

# Check monitoring stack
kubectl get pods -n monitoring

# Check logging stack
kubectl get pods -n logging

# Check CI/CD pipeline
kubectl get pods -n ci
```

## 🔧 Detailed Component Architecture

### **1. VPN Infrastructure (V2Ray)**

#### **USA Endpoint Configuration**
```yaml
# High-level configuration overview
- Protocol: VMess over WebSocket
- Port: 80 (HTTP), 81 (Tunnel)
- Users: 11 configured clients (masked)
- Routing: Smart geo-routing with OpenAI domain handling
- Security: UUID-based authentication, BitTorrent blocking
```

#### **China Endpoint Configuration**
```yaml
# High-level configuration overview
- Protocol: VMess over WebSocket
- Port: 80 (HTTP), 81 (Tunnel)
- Users: 4 configured clients (masked)
- Routing: Geo-location based with portal fallback
- Security: UUID-based authentication, protocol filtering
```

#### **Tunnel Bridge System**
- **Geographic diversity**: USA and China VPN endpoints
- **Domain-based routing**: `usa-usa.tunnel.yimian.xyz`, `usa-china.tunnel.yimian.xyz`
- **Failover mechanism**: Automatic switching between direct and tunnel routes
- **Performance optimization**: Connection reuse and compression

### **2. Static Website Hosting Platform**

#### **Supported Websites**
| Domain | Purpose | Backend | SSL/TLS |
|--------|---------|---------|---------|
| `iotcat.me` | Personal portfolio | GitHub Pages | ✅ Wildcard |
| `blog.yimian.xyz` | Blog platform | `www.eee.dog` | ✅ Wildcard |
| `cloud.yimian.xyz` | Cloud services | FRP tunnel | ✅ Wildcard |
| `drone.yimian.xyz` | CI/CD interface | Drone CI | ✅ Wildcard |
| `grafana.yimian.xyz` | Monitoring dashboard | Grafana | ✅ Wildcard |
| `kibana.yimian.xyz` | Log analysis | Kibana | ✅ Wildcard |
| `prometheus.yimian.xyz` | Metrics collection | Prometheus | ✅ Wildcard |
| `jcdn.yimian.xyz` | CDN services | Custom backend | ✅ Wildcard |
| `imgbed.yimian.xyz` | Image hosting | Custom backend | ✅ Wildcard |
| `share.yimian.xyz` | File sharing | Custom backend | ✅ Wildcard |
| `pay.yimian.xyz` | Payment gateway | Custom backend | ✅ Wildcard |
| `login.yimian.xyz` | Authentication | Custom backend | ✅ Wildcard |
| ... | ... | ... | ... |

#### **Certificate Management**
- **Provider**: Let's Encrypt via cert-manager
- **Challenge Type**: DNS-01 with DNSPod webhook
- **Wildcard Certificates**: `*.yimian.xyz`, `*.iotcat.me`, `*.eee.dog`
- **Auto-renewal**: 30-day renewal cycle with monitoring
- **Storage**: Kubernetes secrets with automatic distribution

### **3. Monitoring & Observability Stack**

#### **Prometheus Configuration**
```yaml
# Monitoring targets and configuration
- Node Exporter: System metrics (CPU, memory, disk, network)
- Kube-State-Metrics: Kubernetes object metrics
- Custom Metrics: Application-specific metrics
- Retention: 30 days of metrics storage
- Alerting: Configured with Alertmanager rules
```

#### **Grafana Dashboards**
- **Infrastructure Overview**: Cluster health, resource utilization
- **Application Metrics**: Service performance, response times
- **Network Monitoring**: Ingress traffic, SSL certificate status
- **Storage Monitoring**: Persistent volume usage, performance
- **Custom Dashboards**: VPN usage, website analytics

#### **Alerting & Notifications**
- **Critical Alerts**: Pod failures, resource exhaustion
- **Warning Alerts**: High resource usage, certificate expiration
- **Custom Alerts**: VPN connection issues, website downtime
- **Notification Channels**: Email, Slack, webhook integrations

### **4. Centralized Logging (ELK Stack)**

#### **Elasticsearch Cluster**
```yaml
# Elasticsearch configuration
- Version: 8.6.0
- Storage: 150GB persistent volume
- Indices: Time-based with automated rotation
- Retention: 90 days of log storage
- Performance: Single-node optimized for development
```

#### **Logstash Pipeline**
```yaml
# Log processing pipeline
- Input: Beats (Filebeat), Kafka, HTTP
- Filters: Parsing, enrichment, normalization
- Output: Elasticsearch, monitoring endpoints
- Performance: Optimized for high-throughput processing
```

#### **Kibana Interface**
```yaml
# Kibana configuration
- Authentication: Basic auth with masked credentials
- Dashboards: Pre-configured for infrastructure monitoring
- Visualizations: Log analysis, error tracking, performance metrics
- Storage: 10GB for configuration and temporary data
```

### **5. CI/CD Pipeline (Drone CI)**

#### **Build System**
```yaml
# Drone CI configuration
- Version: 2.12.1
- Runners: Kubernetes-native execution
- Storage: 20GB for build artifacts and caches
- Integration: Git webhooks, Docker registry
- Security: Token-based authentication, encrypted secrets
```

#### **Pipeline Capabilities**
- **Multi-stage Builds**: Test, build, deploy stages
- **Kubernetes Integration**: Native k8s job execution
- **Docker Support**: Container building and pushing
- **Artifact Management**: Build artifact storage and distribution
- **Notification System**: Build status notifications

### **6. Reverse Proxy & NAT Traversal (FRP)**

#### **FRP Server Configuration**
```yaml
# FRP Server (frps) configuration
- Protocol: QUIC for performance
- Dashboard: Web-based management interface
- Authentication: Token-based security (masked)
- Ports: Multiple service exposure (SSH, HTTPS, custom)
```

#### **Service Exposure**
- **SSH Tunneling**: Remote server access via secure tunnels
- **HTTPS Proxying**: Internal service exposure through HTTPS
- **Custom Protocols**: Support for various application protocols
- **Load Balancing**: Traffic distribution across multiple backends

### **7. Message Queue Infrastructure (Kafka)**

#### **Kafka Configuration**
```yaml
# Apache Kafka setup
- Purpose: Log streaming, event processing
- Integration: Logstash input, Filebeat output
- Scalability: Single-node for development, multi-node ready
- Persistence: Data retention configuration
```

## 🔒 Security Features & Best Practices

### **Transport Layer Security**
- **TLS Everywhere**: End-to-end encryption for all communications
- **Certificate Management**: Automated Let's Encrypt certificates with DNS-01 challenges
- **Perfect Forward Secrecy**: Modern TLS configurations with secure cipher suites
- **HSTS Headers**: HTTP Strict Transport Security for all web services
- **SSL/TLS Termination**: Centralized at ingress controller with proper certificate distribution

### **Network Security**
- **Network Policies**: Service-to-service communication isolation
- **Ingress Filtering**: Rate limiting, IP whitelisting, and DDoS protection
- **Internal DNS**: Service discovery through Kubernetes DNS with private zones
- **Firewall Rules**: Pod-level and node-level traffic filtering
- **VPN Security**: UUID-based authentication with protocol filtering

### **Authentication & Authorization**
- **RBAC**: Role-Based Access Control for Kubernetes resources
- **Service Accounts**: Dedicated accounts for each service with minimal permissions
- **Token-based Authentication**: Secure API access with rotating tokens
- **Secret Management**: Kubernetes secrets with proper encryption at rest
- **Multi-factor Authentication**: Where applicable for administrative access

### **Pod & Container Security**
- **Security Contexts**: Non-root containers with read-only filesystems
- **Resource Limits**: CPU and memory constraints to prevent resource exhaustion
- **Image Security**: Container image scanning and vulnerability assessment
- **Pod Security Policies**: Enforcement of security standards across deployments
- **Network Policies**: Micro-segmentation at the pod level

### **Monitoring & Auditing**
- **Security Monitoring**: Real-time alerting on security events
- **Audit Logs**: Comprehensive logging of all administrative actions
- **Vulnerability Scanning**: Regular security assessments of infrastructure
- **Compliance Monitoring**: Continuous compliance checking and reporting
- **Incident Response**: Automated response to security incidents

## 💾 Storage Architecture & Data Management

### **Persistent Volume Strategy**
```yaml
# Storage configuration overview
Storage Type: Host-path based persistent volumes
Performance: SSD-optimized for database workloads
Scalability: Expandable volumes with automatic provisioning
```

### **Data Persistence Breakdown**
| Service | Storage Size | Purpose |
|---------|-------------|---------|
| **Grafana** | 30GB | Dashboards, configurations |
| **Elasticsearch** | 150GB | Log storage, indices |
| **Drone CI** | 20GB | Build artifacts, caches |
| **Kibana** | 10GB | Configurations, temp data |

### **Storage Configuration**
```yaml
# Storage implementation
- Host-path based persistent volumes
- Kubernetes persistent volume claims
- Configurable storage classes for different workloads
```

## 📋 System Requirements & Prerequisites

### **Kubernetes Cluster Requirements**
```yaml
# Cluster specifications
Kubernetes Version: 1.23.3+ (tested configuration)
Nodes: Flexible (1+ master, 1+ workers)
Storage: Persistent volume support required
Network: Standard Kubernetes networking
```

### **Node Labeling Requirements**
```bash
# Required node labels for proper scheduling
kubectl label node <node-name> role=main              # Master/main nodes
kubectl label node <node-name> role=worker            # Worker nodes
kubectl label node <node-name> location=usa           # Geographic location
kubectl label node <node-name> location=china         # Geographic location
kubectl label node <node-name> v2ray=enabled          # VPN-capable nodes
kubectl label node <node-name> storage=fast           # High-performance storage
```

### **External Dependencies**
- **DNS Provider**: DNSPod account with API access for certificate management
- **Container Registry**: Docker Hub or private registry for image storage
- **Git Repository**: GitHub/GitLab for source code and CI/CD integration

### **Self-Hosted Infrastructure Considerations**

#### **🏠 Physical Machine Setup (Homi Branch)**
```yaml
# Old laptop/desktop conversion considerations
Power Management: 
  - Disable suspend/hibernate modes
  - Configure "lid close" behavior (for laptops)
  - UPS for power protection recommended
  - Power consumption: ~15-50W typical

Cooling & Maintenance:
  - Ensure adequate ventilation
  - Clean dust regularly from fans/vents
  - Monitor temperatures (lm-sensors recommended)
  - Replace thermal paste if necessary

Network Setup:
  - Ethernet connection preferred over WiFi
  - Static IP assignment on local network
  - Port forwarding for external access (if needed)
  - No public IP required for homi branch

Storage Optimization:
  - SSD recommended for system drive
  - Large HDD for log storage (cheaper $/GB)
  
  - Log rotation and cleanup policies
```

### **Network Requirements**
```yaml
# Network configuration requirements
Pod CIDR: 10.244.0.0/16 (Flannel default)
Service CIDR: 10.96.0.0/12 (Kubernetes default)
Ingress Ports: 80, 443 (HTTP/HTTPS)
NodePort Range: 30000-32767
Internal Ports: 6443 (Kubernetes API), 2379-2380 (etcd)
```

## 🛠️ Advanced Configuration

### **Custom Helm Values**

#### **Ingress-Nginx Customization**
```yaml
# ingress-nginx/values.yaml example customizations
controller:
  replicaCount: 2
  resources:
    requests:
      cpu: 500m
      memory: 512Mi
  config:
    use-real-ip: "true"
    real-ip-header: "X-Forwarded-For"
    compute-full-forwarded-for: "true"
  metrics:
    enabled: true
    service:
      annotations:
        prometheus.io/scrape: "true"
```

#### **Prometheus Configuration**
```yaml
# monitoring/prometheus/values.yaml example
server:
  retention: "30d"
  persistentVolume:
    size: 50Gi
  resources:
    requests:
      cpu: 500m
      memory: 1Gi
  global:
    scrape_interval: 15s
    evaluation_interval: 15s
```

### **Environment-Specific Configurations**

#### **Production Environment**
```yaml
# Production-specific settings
- Higher resource limits and requests
- Multi-replica deployments for HA
- External load balancers
- Enhanced monitoring and alerting
- Stricter security policies

```

#### **Development Environment**
```yaml
# Development-specific settings
- Reduced resource requirements
- Single-replica deployments
- Local storage volumes
- Enhanced logging and debugging
- Relaxed security for development ease
- Rapid deployment and iteration
```

### **Performance Tuning**

#### **Database Optimization**
```yaml
# Elasticsearch tuning
- JVM heap size: 50% of available memory
- Index lifecycle management: Automated rollover
- Replica shards: 0 for development, 1+ for production
- Query optimization: Index templates and mappings
```

#### **Application Performance**
```yaml
# General performance optimizations
- Resource limits: Prevent resource starvation
- Readiness/Liveness probes: Health check optimization
- Image optimization: Multi-stage builds, minimal base images
- Caching strategies: Redis/Memcached integration
```

## 🔍 Troubleshooting Guide

### **Common Issues & Solutions**

#### **Certificate Management Issues**
```bash
# Check certificate status
kubectl get certificates -n static-sites
kubectl describe certificate <cert-name> -n static-sites

# Check cert-manager logs
kubectl logs -n cert-manager deployment/cert-manager

# Manual certificate debugging
kubectl get challenges -n static-sites
kubectl describe challenge <challenge-name> -n static-sites
```

#### **Ingress Controller Problems**
```bash
# Check ingress controller status
kubectl get pods -n ingress -l app.kubernetes.io/name=ingress-nginx
kubectl logs -n ingress deployment/nginx-ingress-controller

# Test ingress connectivity
kubectl get ingress --all-namespaces
curl -I https://<domain-name>
```

#### **Storage Issues**
```bash
# Check persistent volume status
kubectl get pv
kubectl get pvc --all-namespaces

# Debug storage problems
kubectl describe pv <pv-name>
kubectl describe pvc <pvc-name> -n <namespace>

# Check storage usage
kubectl exec -n <namespace> <pod-name> -- df -h
```

#### **Service Discovery Problems**
```bash
# Test DNS resolution
kubectl run -it --rm debug --image=busybox --restart=Never -- nslookup <service-name>.<namespace>.svc.cluster.local

# Check service endpoints
kubectl get endpoints -n <namespace>
kubectl describe service <service-name> -n <namespace>
```

### **Monitoring & Alerting Issues**

#### **Prometheus Troubleshooting**
```bash
# Check Prometheus targets
kubectl port-forward -n monitoring svc/prometheus 9090:9090
# Access http://localhost:9090/targets

# Check metric collection
kubectl logs -n monitoring deployment/prometheus-server

# Validate service monitors
kubectl get servicemonitor --all-namespaces
```

#### **Logging Pipeline Issues**
```bash
# Check Filebeat status
kubectl logs -n logging daemonset/filebeat

# Verify Elasticsearch cluster health
kubectl exec -n logging deployment/elasticsearch -- curl -X GET "localhost:9200/_cluster/health?pretty"

# Check Logstash pipeline
kubectl logs -n logging deployment/logstash
```

### **Performance Debugging**

#### **Resource Utilization**
```bash
# Check node resource usage
kubectl top nodes
kubectl describe node <node-name>

# Check pod resource usage
kubectl top pods --all-namespaces
kubectl describe pod <pod-name> -n <namespace>
```

#### **Network Performance**
```bash
# Test network connectivity
kubectl exec -it <pod-name> -n <namespace> -- ping <target-ip>
kubectl exec -it <pod-name> -n <namespace> -- wget -O /dev/null <url>

# Check ingress performance
curl -w "@curl-format.txt" -o /dev/null -s <url>
```

## 📚 Learning Resources & References

### **Kubernetes Documentation**
- [Official Kubernetes Documentation](https://kubernetes.io/docs/)
- [Helm Documentation](https://helm.sh/docs/)
- [NGINX Ingress Controller](https://kubernetes.github.io/ingress-nginx/)
- [cert-manager Documentation](https://cert-manager.io/docs/)

### **Monitoring & Observability**
- [Prometheus Documentation](https://prometheus.io/docs/)
- [Grafana Documentation](https://grafana.com/docs/)
- [Elasticsearch Guide](https://www.elastic.co/guide/)
- [Kibana User Guide](https://www.elastic.co/guide/en/kibana/)

### **CI/CD & DevOps**
- [Drone CI Documentation](https://docs.drone.io/)
- [GitOps Best Practices](https://www.gitops.tech/)
- [Kubernetes Security Best Practices](https://kubernetes.io/docs/concepts/security/)

### **Networking & Security**
- [V2Ray Documentation](https://www.v2ray.com/)
- [FRP Documentation](https://github.com/fatedier/frp)
- [Kubernetes Network Policies](https://kubernetes.io/docs/concepts/services-networking/network-policies/)

## Important Notes

⚠️ **This is a demo version** - You'll need to:
1. Replace all masked values with real ones
2. Configure your own DNS provider
3. Set up proper authentication
4. Adjust paths and storage according to your environment

💡 **Deployment Strategy Recommendations:**
- **Main Branch**: Deploy on cloud instances with public IPs for production VPN and web services
- **Homi Branch**: Perfect for repurposed old laptops/desktops with large storage for cost-effective logging infrastructure
- **Hybrid Approach**: Combine cloud public services with self-hosted private logging for optimal cost/performance balance

## License

This project is provided for demonstration purposes. 