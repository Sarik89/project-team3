Project Pipeline
In this project, Automated deployment of Wordpress web application to Google Cloud Platform (GCP) is achieved with Continuous Delivery pipeline.
The pipeline runs on a GitHub Actions workflow and it has a job called image-build. This job is responsible for building a Docker image, tagging it, and pushing it to a container registry in Google Cloud Platform.
Prerequisites
Before setting up the pipeline, you'll need to have the following prerequisites:
A GitHub account
A GCP account
The gcloud command-line tool installed and configured with your GCP credentials
Docker installed on your local machine
Access to the SonarQube service, if you plan to use it for code quality analysis Setting up the Pipeline To set up the pipeline for this project, follow these steps:
Setting up the Pipeline
To set up the pipeline for this project, follow these steps:
Fork the project repository to your own GitHub account.
Enable the following APIs:
Google Container Registry API
Cloud Build API
Google Cloud Storage JSON API
Create a new service account with the following IAM roles:
Service Account User ( Basic > Owner )
Generate a new key for the service account and download it as a JSON file.
Add the following repository secrets to your GitHub repository:
PROJECT_ID: The ID of your GCP project
GOOGLE_DOMAIN_NAME: Your domain name.
SERVICE_ACCOUNT: The JSON key file for the service account created in step 3.
Copy the contents of the pipeline.yml file in this repository to a new file in your project repository named
.github/workflows/pipeline.yaml 
The pipeline uses environment variables defined at the beginning of the file to define the repository URL, the application version, the repository region, the GCP project ID, the application name, and the new tag version. There are also Sonar-related environment variables that can be used to enable or disable SonarQube scanning. Modify the values of the environment variables in the pipeline.yml file to match your project setup:
repo: The URL of your project repository
app_version: The version of the application to deploy (e.g., main)
repo_region: The GCP region where you want to deploy your application (e.g., us-central1)
project_id: The ID of your GCP project (same as the PROJECT_ID repository secret)
app_name: The name of your application (e.g., wordpress)
tag_new_version: A unique tag for the new version of the application (e.g., ${GITHUB_SHA})
enable_sonar: Whether to use SonarQube for code quality analysis (e.g., true or false)
sonar_organization: The organization ID for your SonarQube instance
sonar_projectKey: The project key for your SonarQube instance
sonar_login: The authentication token for your SonarQube instance
env:
  repo:            "https://github.com/docker-library/wordpress"
  app_version:     "master"
  repo_region:     "us-central1"
  project_id:      "${{ secrets.PROJECT_ID }}"
  app_name:        "wordpress"
  tag_new_version: "${GITHUB_SHA}"
  repository: "wordpress"
  

  # Sonar stuff, please update accordingly
  enable_sonar:    "true"
  # sonar_organization: "terraform-project-89"
  # sonar_projectKey: "terraform-project-89"
  # sonar_login:  "{{ secrets.sonar_login }}"
Cdelivery YAML file defines a workflow that runs when code is pushed to the main branch. It uses the docker/build-push-action GitHub Action to build and push the Docker image. The tags parameter specifies the name and tag for the Docker image.
- name: SonarCloud Scan
        if: ${{env.enable_sonar == 'true'}}
        uses: SonarSource/sonarcloud-github-action@master
        env:
          SONAR_TOKEN: "${{ secrets.SONAR_TOKEN}}"

          SONAR_HOST_URL: sonarcloud.io
        with:
          projectBaseDir: .
          args: >
            -Dsonar.organization=terraform-project-89
            -Dsonar.projectKey=new-key
            -Dsonar.sources=./
this block of code scans the content with sonarqube and and verifies if it does not have any vulnerability.

Once you have completed these steps, your GitHub Actions workflow will automatically build and push the Docker image to Google Artifact registry. You can customize this workflow to suit your specific needs, such as building different images for different branches or pushing the image to a different Docker registry.
- name: Deploy Application
        working-directory: "project-team3"
        run: |
          terraform apply   \
          -var repository="${{ env.repository }}"     \
          -var app_version="${{ env.app_version }}"   \
          -var app_port="${{ env.app_port }}"          \
          -var google_domain_name="${{ env.google_domain_name }}"          \
          -var app_name="${{ env.app_name }}"   \
          -var region="${{ env.region }}" \
          -var project_id="${{ secrets.PROJECT_ID }}" \
          -var environment="${{ env.environment }}" \
          --auto-approve
Using a custom Helm chart for continuous deployment enables you to automate the deployment of your application changes to production using a CI/CD tool and Kubernetes.

Using the Pipeline
Once you have set up the pipeline, you can use it to deploy new versions of web application to your GCP environment._
To trigger the pipeline, simply push changes to the main branch of your project repository. The pipeline will automatically build a new Docker image of the application, tag it with a unique version number, and push it to the Google Container Registry in your GCP project. The pipeline will then deploy the new image to a Project Infrastructure cluster, making it publicly accessible at the service URL.
If you have enabled SonarQube in the pipeline, the pipeline will also perform a code quality analysis of the application and display the results in your SonarQube instance.
