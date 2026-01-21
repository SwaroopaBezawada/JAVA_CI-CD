# Java WAR CI/CD to AWS ECS (Java 21, Tomcat 9, Terraform, Jenkins, DevSecOps)

This project implements a **multi-module Java (Maven) web application** packaged as a **WAR** and deployed on **Apache Tomcat (Dockerized)**, with a full **CI/CD and cloud deployment pipeline on AWS ECS (Fargate)** using **Terraform**, **Jenkins**, and **container security scanning (Trivy)**.

The application logic is based on an open-source reference project. The main focus of this repository is the **modernization of the runtime stack and the DevOps implementation**.

---

## Credits

This project was built by taking reference from the following open-source project:

* Original Repository: `https://github.com/yankils/hello-world`
* Original Author / Organization: `AR Shankar`

Application-level code belongs to the original author. All DevOps, modernization, containerization, CI/CD, security scanning, and AWS deployment work was implemented in this repository.

---

## What was implemented

### Runtime & Build Modernization

* Upgraded Java build and runtime from legacy versions to **Java 21 (LTS)**
* Updated Maven compiler configuration to use `maven.compiler.release=21`
* Pinned Docker base image to **Tomcat 9 + Java 21 (eclipse-temurin)** for stable and repeatable builds

### Containerization

* Dockerized the WAR-based application using Apache Tomcat
* Optimized Docker build process and WAR deployment strategy

### CI/CD (Jenkins)

* Automated pipeline stages:

  * Source checkout
  * Maven build (WAR)
  * Docker image build
  * Container vulnerability scanning (Trivy)
  * Push image to Amazon ECR
  * Deploy to AWS ECS using Terraform

### Infrastructure as Code (Terraform)

* AWS resources provisioned using Terraform:

  * VPC + public subnets
  * Application Load Balancer
  * ECR repository
  * ECS cluster (Fargate)
  * Task definition & ECS service
  * CloudWatch log group

### DevSecOps

* Integrated **Trivy** container scanning in CI pipeline
* Reports HIGH and CRITICAL vulnerabilities before deployment

---

## Technology Stack

| Layer      | Technology                  |
| ---------- | --------------------------- |
| Language   | Java 21 (LTS)               |
| Build Tool | Maven (multi-module)        |
| Packaging  | WAR                         |
| Runtime    | Apache Tomcat 9             |
| Container  | Docker                      |
| CI/CD      | Jenkins                     |
| Security   | Trivy                       |
| Cloud      | AWS ECS (Fargate), ECR, ALB |
| IaC        | Terraform                   |

---

## Project Structure

```
.
├── Dockerfile
├── Jenkinsfile
├── pom.xml
├── server/
│   └── pom.xml
├── webapp/
│   └── pom.xml
├── infra/
│   └── terraform-ecs-fargate/
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
└── README.md
```

---

## Local Build

```bash
mvn clean package
```

WAR file is generated under:

```
webapp/target/*.war
```

---

## Local Run (Docker + Tomcat)

```bash
docker build -t regapp:latest .
docker run -p 8080:8080 regapp:latest
```

Access:

```
http://localhost:8080/
```

---

## CI/CD Flow (Jenkins)

1. Checkout source code
2. Build WAR using Maven (Java 21)
3. Build Docker image
4. Scan image using Trivy
5. Push image to Amazon ECR
6. Deploy infrastructure & application using Terraform to ECS Fargate

---

## AWS Deployment (ECS Fargate + Terraform)

Terraform configuration is located at:

```
infra/terraform-ecs-fargate/
```

Deployment steps:

```bash
cd infra/terraform-ecs-fargate
terraform init
terraform apply
```

Terraform outputs:

* Application Load Balancer DNS
* ECR repository URL

---

## Amazon Linux 2023 Note

* ECS Fargate uses AWS-managed operating systems internally
* For ECS on EC2, Amazon Linux 2023 is recommended using SSM parameter:

```
/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64
```

---

## Key DevOps Learnings

* Migrating legacy Java builds to modern LTS runtimes
* WAR-based application containerization strategy
* Designing CI/CD pipelines with security scanning
* ECS Fargate architecture & ALB integration
* Infrastructure automation using Terraform
* Secure image distribution using Amazon ECR

---

## Disclaimer

This repository is intended for **learning and demonstration of DevOps and cloud engineering practices**. Application source code is referenced from open-source work with proper credit.
