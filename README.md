## About the Project

This repository contains a simple Java Spring Boot application that displays a welcome message to users. The project also includes Docker, Terraform, Kubernetes manifests, and a GitHub Actions workflow to automate the build, deployment, and infrastructure setup process.

This README provides the steps needed to run, containerize, deploy, and manage the application in a cloud environment.

## Prerequisites

Before you begin, make sure the following tools and resources are available:

- [ ] Java Development Kit (JDK)
- [ ] Apache Maven
- [ ] Docker
- [ ] kubectl
- [ ] AWS CLI
- [ ] Terraform
- [ ] AWS account with a valid access key and secret access key
- [ ] Amazon S3 bucket for storing Terraform state files

## Local Development

1. Clone the repository

   `git clone https://github.com/your-username/your-java-application.git`

2. Build the application

   Navigate to the project root and run:

   `mvn clean install`

3. Run the unit tests

   `mvn clean test`

4. Start the application locally

   `mvn spring-boot:run`

The application will be available at [http://localhost:8080](http://localhost:8080).

## Containerization with Docker

The application has been containerized using Docker. You can refer to the [dockerfile](https://github.com/madhura74/javaWebApp/blob/main/dockerfile) for the image configuration.

Follow these steps to run the container locally:

1. Build the Docker image from the project root

   `docker build -t java_webapp .`

2. Run the Docker container

   `docker run -p 8080:8080 -td java_webapp`

The application will be available at [http://localhost:8080](http://localhost:8080).

## Infrastructure Provisioning with Terraform

The repository includes Terraform configuration files and modules in the [terraform](https://github.com/madhura74/javaWebApp/tree/main/terraform) directory.

This infrastructure provisions an Amazon ECR repository for container images, a VPC and related networking components, and an Amazon EKS cluster.

1. Configure your AWS profile

   `aws configure --profile terraform`

   Enter your AWS access key, secret access key, and preferred region.

2. Initialize Terraform from the `./terraform` directory

   `terraform init`

3. Review the execution plan

   `terraform plan`

4. Create the AWS resources

   `terraform apply`

> Note: The Terraform state file is stored in an S3 bucket that should already exist.

To remove the resources after testing, run:

`terraform destroy`

## Kubernetes Deployment

The application requires a Kubernetes namespace, a deployment resource, and a service of type LoadBalancer to expose it externally.

The manifest files are available in the [manifests](https://github.com/madhura74/javaWebApp/tree/main/manifests) folder.

To deploy the application to EKS, run the following commands:

1. Update the kubeconfig for your cluster

   `aws eks update-kubeconfig --name <eks-name> --region <aws-region>`

2. Create the namespace

   `kubectl apply -f ./manifests/namespace-1.yaml`

3. Create the deployment resource

   `kubectl apply -f ./manifests/deploy-webapp.yaml`

4. Create the service

   `kubectl apply -f ./manifests/service-webapp.yaml`

5. Verify the deployment

   `kubectl get all -n <your-namespace>`

6. Access the application

   Copy the external IP from the service output and open it in a browser.

## CI/CD Workflow with GitHub Actions

The [CI/CD workflow](https://github.com/madhura74/javaWebApp/blob/main/.github/workflows/webapp_cicd.yml) automates the integration and deployment process. It performs the following tasks:

1. Checks out the repository code
2. Runs the unit tests
3. Packages the application into a JAR file
4. Builds a Docker image and pushes it to the ECR repository
5. Deploys the image to the EKS cluster

The pipeline is triggered automatically on commits to the configured branches.

> Note: Before running the pipeline, add the required secrets in GitHub repository settings.

The following secrets are required:

- `AWS_ACCESS_KEY_ID`
- `AWS_EKS_NAME`
- `AWS_REGION`
- `AWS_REPO_NAME`
- `AWS_SECRET_ACCESS_KEY`

To configure them:

1. Go to your GitHub repository.
2. Click Settings.
3. Under Security, select Secrets and variables, then click Actions.
4. Click New repository secret.
5. Enter the secret name and value.
6. Save the secret.

You can also configure environment-specific secrets if needed.

For more information, see [GitHub Actions secrets documentation](https://docs.github.com/en/actions/security-guides/using-secrets-in-github-actions).

To review workflow runs:

1. Open the repository on GitHub.
2. Select Actions.
3. Choose the workflow named Java WebApp CICD.
4. Review the latest run and inspect the status of each job.

