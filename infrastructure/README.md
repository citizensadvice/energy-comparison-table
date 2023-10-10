# Energy Supplier Comparison Table app

- [Folder structure](#folder-structure)
- [Configuration](#configuration)
- [Deployment](#deployment)
  - [AWS resources](#aws-resources)
  - [Helm chart](#helm-chart)

## Folder structure

- [cdk](./cdk) - AWS CDK IaC
- [app/chart](./app/chart) - Helm chart
- [app/stages](./app/stages) - Helm stage ( environment ) value overrides

## Configuration

- environments

Environments are configured in the GitHub repo. Each environment has its own secrets. The deployment action is a matrix job that loops over the list of environments with concurrency 1.

- env vars

Stage (environment) specific env vars can be set in the stage-specific helm overrides - `./app/stages/<stage>.yaml` e.g. [qa.yaml](./app/stages/qa.yaml)

- secrets

Secrets set in GH environments are automatically passed to the helm chart which deploys them as a K8s secret.

## Deployment

### AWS resources

The rails app doesn't need any infrastructure apart from an ECR repository. This is configured using the AWS CDK for Python and is deployed manually.

> **This step is only needed when the repo is first created or when its setting must be updated:**

- Follow the steps in [Welcome to your CDK Python project!](cdk/README.md#welcome-to-your-cdk-python-project) to install the cdk cli, Python venv and the required packages, then login to aws ( `aws sso login` ) and deploy:

`AWS_PROFILE=cita-devops.AWSAdministratorAccess cdk deploy --all --require-approval never`

### Helm chart

The chart is deployed with GHA. It can also be deployed manually by copy/pasting the helm step in the deployment workflow and providing any required env variables and secrets.
