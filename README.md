# Java WAR CI/CD to AWS ECS – Modern DevOps Implementation (Java 21, Tomcat 9, Terraform, Jenkins, DevSecOps)

This repository demonstrates a **production-style DevOps implementation** for a multi-module Java web application packaged as a **WAR** and deployed using **Docker + Apache Tomcat**, with automated **CI/CD, security scanning, and cloud deployment to AWS ECS (Fargate)** using **Terraform**.

The application code is based on an open-source reference project (credited below). The main focus of this repository is the **modernization of the runtime stack and the complete DevOps/cloud engineering implementation**.

---

## Credits & Attribution

This project was built using the following open-source project as a reference for application logic:

* Original Repository: `(https://github.com/yankils/hello-world)`
* Original Author / Organization: `<AR SHANKAR>`

The original application structure and sample classes belong to the author. All modernization, containerization, CI/CD, security scanning, infrastructure design, and AWS deployment work was implemented in this repository.

---

## Project Highlights

### Runtime & Build Modernization

* Migrated legacy Java configuration to **Java 21 (latest LTS)**
* Updated Maven compiler configuration using `maven.compiler.release=21`
* Modernized dependencies (JUnit, Hamcrest, Mockito, Servlet, JSP APIs)
* Updated `web.xml` to Servlet 4.0 schema (Tomcat 9 compatible)

### Containerization

* WAR-based deployment using **Apache Tomcat 9 + Java 21**
* Pinned Docker base image for reproducible builds
* Optimized WAR copy strategy for reliable container startup

### CI/CD Automation (Jenkins)

* End-to-end pipeline stages:

  1. Source checkout
  2. Maven build & tests
  3. Docker image build
  4. Container vulnerability scanning (Trivy)
  5. Push image to Amazon ECR
  6. Deploy infrastructure & service using Terraform

### Infrastructure as Code (Terraform)

* Fully automated AWS infrastructure provisioning:

  * VPC & public subnets
  * Application Load Balancer (ALB)
  * Amazon ECR repository
  * ECS Cluster (Fargate)
  * Task Definition & ECS Service
  * CloudWatch log group

### DevSecOps

* Integrated **Trivy** for container image scanning
* Reports HIGH and CRITICAL vulnerabilities during CI
* ECR image scanning enabled on push

---

## Technology Stack

| Layer      | Technology                              |
| ---------- | --------------------------------------- |
| Language   | Java 21 (LTS)                           |
| Build Tool | Maven (multi-module)                    |
| Packaging  | WAR                                     |
| Runtime    | Apache Tomcat 9                         |
| Container  | Docker                                  |
| CI/CD      | Jenkins                                 |
| Security   | Trivy, Amazon ECR scanning              |
| Cloud      | AWS ECS (Fargate), ALB, ECR, CloudWatch |
| IaC        | Terraform                               |

---

## Repository Structure

```
.
├── Dockerfile
├── Jenkinsfile
├── pom.xml
├── server/
│   ├── pom.xml
│   └── src/
│       ├── main/java/com/example/Greeter.java
│       └── test/java/com/example/TestGreeter.java
├── webapp/
│   ├── pom.xml
│   └── src/main/webapp/WEB-INF/web.xml
├── infra/
│   └── terraform-ecs-fargate/
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
└── README.md
```

---

## Local Build & Test

```bash
mvn clean test
mvn clean package
```

WAR output:

```
webapp/target/*.war
```

---

## Local Run (Docker)

```bash
docker build -t regapp:latest .
docker run -p 8080:8080 regapp:latest
```

Access application:

```
http://localhost:8080/
```

---

## CI/CD Pipeline Overview

Jenkins pipeline automates the following:

1. Compile & test application using Java 21
2. Package WAR using Maven
3. Build Docker image (Tomcat + Java 21)
4. Scan image using Trivy (HIGH/CRITICAL vulnerabilities)
5. Push image to Amazon ECR
6. Provision/update AWS infrastructure using Terraform
7. Deploy container to ECS Fargate behind ALB

---

## AWS Deployment (ECS Fargate)

Terraform configuration is located at:

```
infra/terraform-ecs-fargate/
```

Deployment commands:

```bash
cd infra/terraform-ecs-fargate
terraform init
terraform apply
```

Terraform outputs:

* Application Load Balancer DNS name
* ECR repository URL

---️ After deployment, the application is accessible via the ALB URL.

---

## Amazon Linux 2023 Note

* ECS Fargate uses AWS-managed operating systems internally
* For ECS on EC2, Amazon Linux 2023 is recommended via SSM parameter:

```
/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64
```

---

## Key DevOps & Cloud Engineering Learnings

* Migrating legacy Java applications to modern LTS runtimes
* WAR-based application containerization patterns
* Designing CI/CD pipelines with security gates
* Container image vulnerability management
* ECS Fargate service architecture and ALB integration
* Infrastructure provisioning using Terraform
* Secure container distribution with Amazon ECR

---

## Disclaimer

This repository is intended for **learning and professional portfolio demonstration of DevOps and cloud engineering practices**. Application source code is referenced from open-source work with proper attribution.
