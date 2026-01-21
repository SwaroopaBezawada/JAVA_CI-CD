# Java WAR CI/CD to AWS ECS (Java 21, Tomcat 9, Terraform, Jenkins)

I built this project to understand how a **traditional Java WAR application** can be modernised and deployed on AWS using containers, CI/CD, and Infrastructure as Code.

The application logic itself comes from an open‑source project (credited below). My work here focuses on **upgrading the runtime**, **containerising the app**, **building the CI/CD pipeline**, adding **basic security checks**, and deploying everything to **AWS ECS (Fargate)** using Terraform.

---

## Credits

The application code is based on the following open‑source project:

Original Repository: (https://github.com/yankils/hello-world)
Original Author / Organization: <AR SHANKAR>

I did not write the application logic from scratch. I used it as a reference so I could focus on the DevOps and cloud side of things.

---

## What I worked on

### Java & build upgrades

* Upgraded the project to **Java 21 (LTS)**
* Updated Maven compiler settings to use `maven.compiler.release=21`
* Cleaned up old testing dependencies and moved to newer versions of JUnit, Hamcrest, and Mockito
* Updated `web.xml` to a newer servlet version that works properly with Tomcat 9

### Docker & Tomcat setup

* Containerised the application using **Tomcat 9 + Java 21**
* Removed usage of `latest` Docker tags to avoid unexpected breaking changes
* Set up WAR deployment so the app always runs as the ROOT application

### CI/CD with Jenkins

I created a Jenkins pipeline that:

1. Builds and tests the project with Maven
2. Builds a Docker image
3. Scans the image for vulnerabilities using Trivy
4. Pushes the image to Amazon ECR
5. Deploys the application to ECS using Terraform

### AWS & Terraform

Using Terraform, I provision:

* A VPC and public subnets
* An Application Load Balancer
* An ECS cluster (Fargate)
* Task definitions and ECS service
* CloudWatch log groups
* An ECR repository

This helped me understand how ECS services, networking, and load balancers work together in practice.

### Security basics (DevSecOps)

* Added container vulnerability scanning with **Trivy**
* Enabled image scanning in Amazon ECR

---

## Tech stack (simple view)

* Java 21 (LTS)
* Maven (multi‑module project)
* Tomcat 9
* Docker
* Jenkins
* Terraform
* AWS ECS (Fargate), ECR, ALB, CloudWatch
* Trivy (security scanning)

---

## Project structure

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

## How to build locally

```bash
mvn clean test
mvn clean package
```

The WAR file will be generated in:

```
webapp/target/
```

---

## How to run locally with Docker

```bash
docker build -t regapp:latest .
docker run -p 8080:8080 regapp:latest
```

Then open:

```
http://localhost:8080/
```

---

## CI/CD flow (high level)

* Developer pushes code
* Jenkins builds and tests
* Docker image is created
* Trivy scans the image
* Image is pushed to ECR
* Terraform updates ECS service

---

## AWS deployment

Terraform files are here:

```
infra/terraform-ecs-fargate/
```

Basic steps:

```bash
cd infra/terraform-ecs-fargate
terraform init
terraform apply
```

After deployment, Terraform prints the ALB DNS name which you can open in the browser.

---

## Note on Amazon Linux 2023

* ECS Fargate uses AWS‑managed operating systems internally
* If using ECS on EC2, I would use Amazon Linux 2023 via this SSM parameter:

```
/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64
```

---

## What I learned from this project

* How to modernise an old Java project safely
* How WAR‑based apps are deployed using Tomcat in containers
* How Jenkins pipelines are structured in real projects
* How ECS services, load balancers, and networking work together
* How Terraform helps manage infrastructure changes
* Why container scanning is important before deployment

---

## Final note

This project is mainly for learning and portfolio purposes. The goal was not to build a complex application, but to understand how real‑world Java applications are built, packaged, deployed, and operated using modern DevOps tools.
