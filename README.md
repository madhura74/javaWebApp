## About The Project

This guide provides step-by-step instructions for deploying the javaWebApp, a simple Java spring application which gives a Welcome message to the user. Follow these steps to ensure a smooth deployment process.

Use the `README.md` to get started.

## Pre requisite
Before proceeding with the implementation, ensure that the following prerequisites are met:

- [ ] Java Development Kit (JDK) installed
- [ ] Apache Maven installed
- [ ] Docker 
- [ ] Kubectl
- [ ] AWS account with a valid Access Key Id and secrete access key
- [ ] AWS CLI
- [ ] Terraform
- [ ] Amazon S3 Bucket to store terraform state file.

## Developers
1. Clone the Repository

   ` git clone https://github.com/your-username/your-java-application.git `

2. Build the Application

   Navigate to the application's root directory and build the project using Maven:

   ` mvn clean install `

3. Test the Application 

   ` mvn clean test `

4. Run the application using the following Maven command:

   ` mvn spring-boot:run `

The application will be accessible at [http://localhost:8080](http://localhost:8080).


## Containerisation using Docker

We have used docker to containerise the application. Refer [dockerfile](https://github.com/madhura74/javaWebApp/blob/main/dockerfile) for the code. 

Follow the steps mentioned below to run the dockerised instance of the application from your local machine.

1. Build the docker image from the root directory
   
   ` docker build -t java_webapp . `

3. Run the docker image.
   
   ` docker run -p 8080:8080 -td java_webapp `

The application will be accessible at [http://localhost:8080](http://localhost:8080).

## Infrastructure creation using Terraform 

Have a look at the Terraform files and modules that are present in the folder [terraform](https://github.com/madhura74/javaWebApp/tree/main/terraform).

This infracture consists creation of ECR to store docker images, a VPC and its components and EKS.

1. Set the AWS configuration profile with below command
   
   `aws configure --profile terraform `

   Provide the values of your ID, secrete and region.


3. Initiate the terraform, Run this command from the ./terraform folder
   
   ` terraform init `

4. Terraform Plan
      
   ` terraform plan `

6. Create the resources in AWS
   
   ` terraform apply`

**Note:**

The terraform state file will be referred from S3 bucket which is previosly created. 

If you want to delete the resources after application deployment and testing, run below command.

` terraform destroy `


## Kubernetes Manifests

This application needs a namespace, kubernetes deployment resource which will spin up the instance of the application using the image from ECR.

We also create a kubernetes service of type  load balancer to access the application.

Refer the manifest files present in the folder [manifest](https://github.com/madhura74/javaWebApp/tree/main/manifests).

To deploy the application to EKS, follow the bellow commands.

1. fetch and update the kubeconfig details
   
   ` aws eks update-kubeconfig --name <eks-Name> --region <aws-region> `

3. create the namespace, run the below command. This could be a onetime action, only during the initial setup.
   
   ` kubectl apply -f ./manifests/namespace-1.yaml ` 

4. create the deployment resource, run the below command
   
   ` kubectl apply -f ./manifests/deploy-webapp.yaml ` 

5. create the service, run the below command.
   
   ` kubectl apply -f ./manifests/service-webapp.yaml ` 

6. check the deployment of the resources, run below commands,
      
   ` kubectl get all -n <your namespace> `

7. access the application, by coping the EXTERNAL-IP url from Service details in the response of the above command.


## CICD Workflow using GitHub Actions

[CICD Workflow](https://github.com/madhura74/javaWebApp/blob/main/.github/workflows/webapp_cicd.yml) automates the process of integration and deployment. It majorly consists of below tasks.
1. Checkout the code 
2. Test the unit test cases
3. Package the application into a jar file
4. Build a docker image and push it to ECR repocitory
5. Deploy the docker image to EKS

The pipeline will be automatically triggered upon commits to configured branches.

**Note:** Before executing the pipeline, Store the secretes such as below, in GitHub secretes using following steps. 

AWS_ACCESS_KEY_ID

AWS_EKS_NAME

AWS_REGION

AWS_REPO_NAME

AWS_SECRET_ACCESS_KEY

1. On GitHub.com, navigate to the main page of the repository.
2. your repository name, click  Settings. 
3. In the "Security" section of the sidebar, select  Secrets and variables, then click Actions.
4. Click the Secrets tab.
5. Click New repository secret.
6. In the Name field, type a name for your secret.
7. In the Secret field, enter the value for your secret.
8. Click Add secret.


You can also store your secretes specific to an environment.

[Know more about github secrtes](https://docs.github.com/en/actions/security-guides/using-secrets-in-github-actions)

To check the Pipeline executions, navigate to the main page of the repository.

Select Actions, under All workflows select _Java WebApp CICD_.

Once you select the latest run, you can check the status of all the jobs and tasks it has executed.





