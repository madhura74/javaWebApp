## About The Project

his guide provides step-by-step instructions for deploying the javaWebApp, a simple Java spring application which give a Welcome message to the user. Follow these steps to ensure a smooth deployment process.

Use the `README.md` to get started.

## Pre requisite
Before proceeding with the deployment, ensure that the following prerequisites are met:

- [ ] Java Development Kit (JDK) installed
- [ ] Apache Maven installed
- [ ] Docker
- [ ] Kubectl
- [ ] AWS CLI
- [ ] Terraform
- [ ] Amazon S3 to store terraform state file.

## Developers
Clone the Repository

(` git clone https://github.com/your-username/your-java-application.git `)

Build the Application

Navigate to the application's root directory and build the project using Maven:
(` mvn clean install `)

Test the Application 
(` mvn clean test `)

Run the application using the following Maven command:
(` mvn spring-boot:run `)

The application will be accessible at http://localhost:8080.


## Containerisation using Docker

We have used docker to containerise the application. Refer dockerfile for the code.

Build the docker image from the root directory
(` docker build -t java_webapp . `)

Run the docker image.
(` docker run -p 8080:8080 -td java_webapp `)

The application will be accessible at http://localhost:8080.

## Infrastructure creation using Terraform 
Terraform files are present in the folder terraform. This infracture consists creation of ECR to store docker images, a VPC and its components and EKS.



## Kubernetes Manifestations

## CICD Workflow using GitHub Actions
