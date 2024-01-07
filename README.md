## About The Project

his guide provides step-by-step instructions for deploying the javaWebApp, a simple Java spring application which give a Welcome message to the user. Follow these steps to ensure a smooth deployment process.

Use the `README.md` to get started.

## Pre requisite
Before proceeding with the deployment, ensure that the following prerequisites are met:

- [ ] Java Development Kit (JDK) installed
- [ ] Apache Maven installed
- [ ] Docker
- [ ] Kubectl
- [ ] AWS account with a valid Access Key Id and secrete access key
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

We have used docker to containerise the application. Refer dockerfile for the code. Follow bellow steps to run the dockerised instance of the application from your local machine.

Build the docker image from the root directory
(` docker build -t java_webapp . `)

Run the docker image.
(` docker run -p 8080:8080 -td java_webapp `)

The application will be accessible at http://localhost:8080.

## Infrastructure creation using Terraform 
Have a look at the Terraform files and modules that are present in the folder terraform. This infracture consists creation of ECR to store docker images, a VPC and its components and EKS.

Set the AWS configuration profile with below command
(`aws configure --profile terraform `)
Provide the values of your ID, secrete and region.


Initiate the terraform, Run this command from the ./terraform folder 
(` terraform init `)

Terraform Plan
(` terraform plan `)

Create the resources in AWS
(` terraform apply`)

Note :
The terraform state file will be referred from S3 bucket which us previosly created. 

If you want to delete the resources after application deployment and testing, run below command.
(` terraform destroy `)


## Kubernetes Manifestations
This application needs a namespace, kubernetes deployment resource which will spin up the instance of the application using the image from ECR.
We also create a kubernetes service of type  load balancer to access the application.
Refer the manifest files present in the folder manifest

To deploy the application to EKS, follow the bellow commands.

To fetch and update the kubeconfig details
(` aws eks update-kubeconfig --name <eks-Name> --region <aws-region> `)

To create the namespace, run the below command. This could be a onetime action, for the initial set up.
(` kubectl apply -f ./manifests/namespace-1.yaml `) 

To create the deployment resource, run the below command
(` kubectl apply -f ./manifests/deploy-webapp.yaml `) 

To create the service, run the below command.
(` kubectl apply -f ./manifests/service-webapp.yaml `) 

To check the deployment of the resources, run below commands,
(` kubectl get all -n <your namespace> 

From the service created, copy the EXTERNAL-IP url to access the application.


## CICD Workflow using GitHub Actions

This Workflow automates the process of integration of the application and and deployment. It majorly consists of below tasks.
1. Checkout the code 
2. Test the unit test cases
3. Package the application into a jar
4. Build a docker image and push it to ECR repocitory
5. Deploy the docker image to EKS

Store the secretes such as AWS credentials using GitHub secretes.

[To know more](https://docs.github.com/en/actions/security-guides/using-secrets-in-github-actions)



