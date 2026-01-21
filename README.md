## DevOps Project for Beginners   

This repository contains a Java-based sample web application that is containerized using Docker and deployed to AWS infrastructure. The original project demonstrates a simple end-to-end flow of building a Java application, packaging it into a Docker image, and deploying it using cloud-native services.
This version of the repository focuses on modernizing the technology stack and documenting the DevOps-related analysis, upgrades, and learnings.
________________________________________
Original Source & Credits
This project is based on an open-source repository created by the original author.
•	Original Repository:
•	Original Author:
All application-level logic belongs to the original author. This repository is maintained for learning and DevOps practice purposes, with a focus on upgrading outdated components and improving deployment readiness.
________________________________________
What This Project Does
•	Java web application built using Maven
•	Packaged as a Docker container
•	Deployed to AWS infrastructure
•	Exposed as a web service
________________________________________
Technology Stack (Before vs After)
Before (Original Project)
•	Java 11
•	Amazon Linux AMI 2
•	Older OpenJDK Docker images
After (Modernization – Partially Implemented)
•	Java 21 (LTS) – implemented in Docker and Maven
•	Amazon Linux 2023 – documented and planned
•	Updated, supported Java 21 Docker base image
________________________________________
Project Status
This repository represents a DevOps modernization exercise.
•	✅ Java runtime upgraded to Java 21 LTS (implemented)
•	🟡 OS upgrade to Amazon Linux 2023 (analyzed and documented)
•	🟡 Further CI/CD and infra improvements planned
The original application code is intentionally retained for reference, while modernization decisions and partial upgrades are documented transparently.
________________________________________
Why Modernization Was Needed
During analysis, it was observed that several components used in the original project are approaching end-of-support or are no longer recommended for new deployments:
•	Java 11 is nearing the end of mainstream support
•	Amazon Linux 2 is being gradually replaced by Amazon Linux 2023
•	Older container images increase security risk and maintenance overhead
Modernizing these components aligns the project with current AWS and Java best practices, making it more relevant for real-world DevOps environments.
________________________________________
Detailed Changes & Impact Analysis
1. Java Upgrade: Java 11 → Java 17 (LTS)
What changed:
•	Maven configuration updated to use Java 17
•	Dockerfile updated to use a Java 17-compatible base image
Why:
•	Java 17 is the current Long-Term Support (LTS) release
•	Better performance, security patches, and long-term stability
Impact:
•	No application code changes required
•	Improved runtime performance
•	Safer choice for production workloads
________________________________________
2. Base OS Upgrade: Amazon Linux 2 → Amazon Linux 2023
What changed:
•	Deployment configuration updated to reference Amazon Linux 2023
Why:
•	Amazon Linux 2023 provides faster updates and improved security posture
•	Closer alignment with upstream Linux distributions
Impact:
•	Better package management
•	Reduced technical debt
•	Long-term AWS support
________________________________________
3. Docker Image Improvements
What changed:
•	Updated base image versions
•	Reduced attack surface
•	Improved image consistency
Why:
•	Older images may contain known vulnerabilities
•	Modern images improve build reliability
Impact:
•	Smaller, more secure images
•	Faster build and deployment cycles
________________________________________
Challenges Faced & Learnings
•	Ensuring Java version compatibility across Maven, Docker, and runtime
•	Understanding AWS OS lifecycle and deprecation timelines
•	Importance of aligning application runtime with cloud provider best practices
These challenges provided hands-on experience in real-world DevOps modernization tasks.
________________________________________
How to Build and Run
mvn clean package

docker build -t java-webapp .
docker run -p 8080:8080 java-webapp
________________________________________
Key DevOps Learnings
•	Importance of tracking software lifecycle and end-of-support
•	Safe upgrade paths for Java-based applications
•	Docker image and OS selection impact on security and maintenance
•	Modernization is a core DevOps responsibility, not just application development
________________________________________
CI/CD and Build Improvements (Added)
.dockerignore
A .dockerignore file is recommended to exclude unnecessary files such as .git, target/, and local configuration files from the Docker build context. This reduces image size and improves build performance.
CI/CD (GitHub Actions – Planned)
A CI pipeline is planned to:
•	Build the project using Maven
•	Validate Java 21 compatibility
•	Build the Docker image
•	(Optional) Push the image to a container registry
This mirrors real-world DevOps workflows where runtime upgrades are validated automatically.

