# LinuxOps — Linux Server Monitoring & Auto-Healing Platform

> A lightweight Linux server operations platform that detects common infrastructure failures, creates incidents, sends alerts, and performs configurable automated recovery actions.

---

## 📌 Overview

**LinuxOps** is a Linux-based server monitoring and auto-healing platform designed to reduce the amount of manual intervention required when common server problems occur.

In real-world environments, Linux servers can experience:

* High CPU utilization
* Memory pressure
* Disk space exhaustion
* Unexpected service failures
* Abnormal processes
* Network connectivity problems
* Repeated SSH authentication failures

LinuxOps continuously monitors these conditions, detects predefined problems, records incidents, alerts administrators, and can execute controlled recovery actions.

### Core workflow

```text
              ┌──────────────────┐
              │   Linux Server   │
              └────────┬─────────┘
                       │
                       ▼
              ┌──────────────────┐
              │  LinuxOps Agent  │
              └────────┬─────────┘
                       │
          ┌────────────┼────────────┐
          ▼            ▼            ▼
       Metrics      Services      Security
          │            │            │
          └────────────┼────────────┘
                       ▼
              ┌──────────────────┐
              │ Detection Engine │
              └────────┬─────────┘
                       │
                 ┌─────┴─────┐
                 ▼           ▼
              Incident      Alert
                 │
                 ▼
          ┌──────────────────┐
          │ Auto-Healing     │
          └────────┬─────────┘
                   │
                   ▼
          Verify Recovery
                   │
                   ▼
             Store Results
```

---

# 🎯 Problem Statement

System administrators and DevOps teams need to continuously monitor Linux servers and respond when services or infrastructure resources become unhealthy.

For example:

```text
Nginx stops
     ↓
Application becomes unavailable
     ↓
Administrator discovers the problem
     ↓
Administrator manually restarts Nginx
```

LinuxOps aims to reduce this manual response for predefined and safe failure scenarios:

```text
Nginx stops
     ↓
LinuxOps detects failure
     ↓
Incident created
     ↓
Recovery action triggered
     ↓
Nginx restarted
     ↓
Health check performed
     ↓
Recovery recorded
```

---

# 🚀 Key Features

## 1. System Resource Monitoring

LinuxOps collects important Linux system metrics:

* CPU utilization
* Memory utilization
* Disk utilization
* Load average
* Network traffic
* Running processes

Example:

```text
CPU Usage       : 72%
Memory Usage    : 51%
Disk Usage      : 81%
Load Average    : 2.31
Running Process : 187
```

---

## 2. Service Monitoring

LinuxOps can monitor important Linux services such as:

```text
Nginx
Apache
MySQL
SSH
Docker
Spring Boot
```

Example:

```text
Service: nginx

Status:
DOWN

Action:
Restart attempted

Result:
RECOVERED
```

---

## 3. Failure Detection

The system uses configurable thresholds and health checks.

Example:

```text
CPU > 90% for 2 minutes
        ↓
Create incident
        ↓
Identify high CPU processes
        ↓
Generate alert
```

Another example:

```text
Disk usage > 85%
        ↓
Create incident
        ↓
Identify large files/directories
        ↓
Generate alert
```

---

# 🚑 4. Auto-Healing

LinuxOps can perform predefined recovery actions for supported failures.

Example:

```text
NGINX DOWN
     ↓
Detection
     ↓
Recovery Action
     ↓
systemctl restart nginx
     ↓
Health Check
     ↓
NGINX RUNNING
```

Auto-healing actions are intentionally limited to predefined operations rather than allowing unrestricted commands.

---

# 🔐 5. Security Monitoring

LinuxOps monitors Linux authentication logs for suspicious authentication activity.

For example:

```text
Multiple failed SSH attempts
          ↓
Extract source IP
          ↓
Create security event
          ↓
Generate alert
```

The initial version focuses on **detection and alerting**. Automated blocking can be added later as a configurable security feature.

---

# 📊 6. Incident Management

Every detected problem can be recorded as an incident.

Example:

```text
Incident ID : INC-1024
Server      : Ubuntu-EC2
Type        : SERVICE_FAILURE
Service     : nginx
Status      : RECOVERED
Action      : RESTART_SERVICE
Time        : 10:42:15
```

This creates a historical record of infrastructure problems and recovery actions.

---

# 🌐 7. REST API

The Spring Boot backend exposes APIs for accessing monitoring and incident information.

Example endpoints:

```http
POST /api/servers/register

GET /api/servers

GET /api/servers/{id}/metrics

GET /api/servers/{id}/processes

GET /api/servers/{id}/services

GET /api/alerts

GET /api/incidents

GET /api/incidents/{id}
```

---

# 🖥️ Dashboard

The dashboard provides a centralized view of Linux server health.

Example:

```text
┌─────────────────────────────────────────────┐
│                  LinuxOps                   │
├─────────────────────────────────────────────┤
│                                             │
│ CPU       RAM       DISK       NETWORK      │
│ 72%       51%       81%        14 MB/s      │
│                                             │
├─────────────────────────────────────────────┤
│ SERVICES                                    │
│                                             │
│ NGINX      RUNNING                          │
│ MYSQL      RUNNING                          │
│ SSH        RUNNING                          │
│ DOCKER     RUNNING                          │
│                                             │
├─────────────────────────────────────────────┤
│ INCIDENTS                                   │
│                                             │
│ Active: 1                                   │
│ Recovered: 14                               │
│                                             │
└─────────────────────────────────────────────┘
```

---

# 🏗️ Architecture

```text
                         ┌──────────────────┐
                         │   Linux Server   │
                         │                  │
                         │ CPU              │
                         │ Memory           │
                         │ Disk             │
                         │ Processes        │
                         │ Services         │
                         │ Logs             │
                         └────────┬─────────┘
                                  │
                                  ▼
                         ┌──────────────────┐
                         │ LinuxOps Agent   │
                         │     Bash         │
                         └────────┬─────────┘
                                  │
                                  │ REST
                                  ▼
                     ┌────────────────────────┐
                     │    Spring Boot API     │
                     │                        │
                     │ Monitoring             │
                     │ Incident Management    │
                     │ Alert Management       │
                     │ Recovery Engine        │
                     └───────────┬────────────┘
                                 │
                    ┌────────────┴────────────┐
                    ▼                         ▼
             ┌──────────────┐         ┌──────────────┐
             │    MySQL     │         │  Dashboard   │
             └──────────────┘         └──────────────┘
                                  
                                  
                     ┌────────────────────────┐
                     │       AWS EC2          │
                     │     Ubuntu Linux       │
                     └────────────────────────┘
```

---

# 🛠️ Technology Stack

### Operating System

* Ubuntu Linux
* Bash Shell
* systemd
* Linux networking tools

### Backend

* Java
* Spring Boot
* Spring Web
* Spring Data JPA
* REST API

### Database

* MySQL

### DevOps

* Git
* GitHub
* Docker
* Docker Compose
* GitHub Actions
* Nginx

### Cloud

* AWS EC2

---

# 📁 Project Structure

```text
linuxops/
│
├── linuxops-agent/
│   ├── cpu.sh
│   ├── memory.sh
│   ├── disk.sh
│   ├── network.sh
│   ├── processes.sh
│   ├── services.sh
│   ├── security.sh
│   └── monitor.sh
│
├── linuxops-backend/
│   ├── src/
│   │   ├── controller/
│   │   ├── service/
│   │   ├── repository/
│   │   ├── entity/
│   │   └── dto/
│   │
│   └── pom.xml
│
├── linuxops-dashboard/
│
├── docker/
│   └── docker-compose.yml
│
├── deployment/
│   ├── nginx/
│   ├── systemd/
│   └── aws/
│
├── docs/
│   ├── architecture.md
│   ├── api.md
│   └── incident-scenarios.md
│
├── README.md
└── .gitignore
```

---

# ⚙️ Linux Monitoring Commands

LinuxOps uses standard Linux system interfaces and commands such as:

```bash
top
ps
free
df
du
uptime
vmstat
ss
ip
systemctl
journalctl
grep
awk
sed
curl
```

Examples:

### CPU

```bash
top
```

### Memory

```bash
free -h
```

### Disk

```bash
df -h
```

### Running processes

```bash
ps aux
```

### Service status

```bash
systemctl status nginx
```

### Network connections

```bash
ss -tulpn
```

---

# 🧪 Failure Simulation

LinuxOps can be tested by intentionally creating controlled failures.

### Test 1 — Stop Nginx

```bash
sudo systemctl stop nginx
```

Expected workflow:

```text
Nginx stopped
     ↓
LinuxOps detects failure
     ↓
Incident created
     ↓
Restart action
     ↓
Health check
     ↓
Nginx recovered
```

---

### Test 2 — High Disk Usage

Create a controlled test file:

```bash
fallocate -l 500M test-file.img
```

Then monitor:

```bash
df -h
```

LinuxOps should detect the configured threshold and generate an incident.

---

### Test 3 — SSH Authentication Monitoring

Generate controlled failed authentication attempts and inspect:

```bash
sudo journalctl -u ssh
```

or, depending on the distribution:

```bash
sudo tail -f /var/log/auth.log
```

LinuxOps detects repeated failures and creates a security event.

---

# ☁️ AWS Deployment

The production-style deployment uses an AWS EC2 Ubuntu instance.

```text
Developer Laptop
       │
       │ Git Push
       ▼
    GitHub
       │
       ▼
GitHub Actions
       │
       ▼
    AWS EC2
       │
       ├── Ubuntu
       ├── LinuxOps Agent
       ├── Spring Boot
       ├── MySQL
       └── Nginx
```

---

# 🐳 Docker Deployment

Application components can be containerized using Docker.

Example:

```text
Docker Compose
│
├── linuxops-backend
├── mysql
└── dashboard
```

The Linux monitoring agent can continue operating at the host level where it has access to host system metrics.

---

# 🔄 CI/CD

The planned CI/CD workflow:

```text
Developer
    │
    ▼
git push
    │
    ▼
GitHub
    │
    ▼
GitHub Actions
    │
    ├── Build
    ├── Test
    ├── Package
    └── Deploy
            │
            ▼
          AWS EC2
```

---

# 📈 Example Incident Lifecycle

```text
DETECTED
    │
    ▼
INVESTIGATING
    │
    ▼
RECOVERY_ATTEMPTED
    │
    ▼
   ┌───────────────┐
   │               │
   ▼               ▼
RECOVERED       FAILED
   │               │
   ▼               ▼
RESOLVED         ALERT
```

This allows the project to maintain an audit trail of infrastructure events.

---

# 🔒 Security Considerations

LinuxOps follows a controlled recovery approach.

* Recovery commands are predefined.
* The monitoring agent should run with the minimum required privileges.
* API authentication should be enabled.
* Sensitive credentials should never be committed to Git.
* AWS security groups should expose only required ports.
* Database credentials should be stored using environment variables or a secret-management mechanism.
* Security events should be logged for auditing.

---

# 🎯 Future Improvements

Possible future versions can include:

* Multi-server monitoring
* Role-based access control
* Prometheus integration
* Grafana dashboards
* Email/Telegram notifications
* Kubernetes monitoring
* Container health monitoring
* CloudWatch integration
* Anomaly detection
* Predictive alerting
* Centralized log collection
* Infrastructure-as-Code using Terraform

---

# 📊 Project Goals

The project aims to demonstrate practical knowledge of:

```text
Linux Administration
        +
System Monitoring
        +
Networking
        +
Bash Automation
        +
Java Backend
        +
Spring Boot
        +
Database
        +
Docker
        +
AWS
        +
CI/CD
```

---

# 👨‍💻 Skills Demonstrated

* Linux system administration
* Shell scripting
* Process management
* Service management
* Linux networking
* Log analysis
* REST API development
* Java backend development
* Database integration
* Docker containerization
* AWS EC2 deployment
* CI/CD automation
* Infrastructure monitoring
* Incident management
* Automated recovery

---

# 🚀 Project Status

```text
[ ] Linux monitoring agent
[ ] CPU monitoring
[ ] Memory monitoring
[ ] Disk monitoring
[ ] Process monitoring
[ ] Service monitoring
[ ] Security log monitoring
[ ] Incident management
[ ] Auto-healing
[ ] Spring Boot API
[ ] MySQL integration
[ ] Dashboard
[ ] Docker
[ ] AWS EC2 deployment
[ ] CI/CD
```

> This project is being developed incrementally, with each stage tested on a Linux environment before integration into the complete platform.

---

# 📄 License

This project is intended for educational and portfolio purposes.
