# Terraform with .NET 6 web API and azure devops

## Steps

- When the code changes push in to github then azure devops pipeline triggered.

- As a part of the pipeline it creats a docker image from web api and push it in to DockerHub (or any other image regitory).

```
- stage: Build
    displayName: Build image
    jobs:
      - job: Build
        displayName: Build
        pool:
          vmImage: ubuntu-latest
        steps:
          - task: Docker@2
            inputs:
              containerRegistry: "{name of the container registory service linked with pipeline}"
              repository: "{repository/image}"
              command: "buildAndPush"
              Dockerfile: "**/Dockerfile"
```

- After above step complete provision process started. Here use the terraform file.

```
stage: Provision
    displayName: "Terraforming on Azure..."
    dependsOn: Build
    jobs:
      - job: Provision
        displayName: "Provisioning Container Instance"
        pool:
          vmImage: "ubuntu-latest"
        variables:
          - group: {environmnet variable grp define in devops variables/appsettings.json}
        steps:
          - script: |
              set -e
              terraform init -input=false
              terraform apply -input=false -auto-approve
            name: "RunTerraform"
            displayName: "Run Terraform"
            env:
              ARM_CLIENT_ID: $(ARM_CLIENT_ID)
              ARM_CLIENT_SECRET: $(ARM_CLIENT_SECRET)
              ARM_TENANT_ID: $(ARM_TENANT_ID)
              ARM_SUBSCRIPTION_ID: $(ARM_SUBSCRIPTION_ID)
              TF_VAR_imagebuild: $(tag)

```
