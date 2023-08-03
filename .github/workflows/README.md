# Github Action Workflows

This README details information on the workflows and anciliary files for this repository.

## Review App Workflows

Implemented as part of epic [OPS-4891](https://citizensadvice.atlassian.net/browse/OPS-4891). Please see the epic and related tickets for information on their development.

For a diagramatic representation of the review app workflows, please see [this Confluence document](https://citizensadvice.atlassian.net/wiki/spaces/OPS/pages/3479699470/Review+Apps#Workflow-Diagrams).

### review-app-create

Used to create or a update a review app environment. It is triggered if a pull request that is labeled with `Review app`, is pushed to, marked as ready for review.

The workflow contains two jobs. In order, the workflow will:

1. Checkout the application code
2. Install dependencies, configure AWS credentials and log into ECR
3. Checks if an image has already been built of this commit hash, if it has then it skips the next step
4. Builds the image will the image tag being `review-<commit hash>`
5. Install additional dependencies and configure the kube config
6. Optionally create a namespace if there is none that match the name
7. Deploy Casebook using Helm with a variety of overrides
8. Add or ammend a comment on the PR with information on how to access the environment

### review-app-destroy

Will destroy a review app environment. It is triggered if:

- The label `Review app` is removed from a pull request
- The PR is closed or marked as draft
- Manually though the Github dispatch workflow UI

In order, the workflow will:

1. Removed the `Review app` label if it has not already been removed
2. Ensure the required dependencies are installed (aws-cli, kubectl) and configure AWS credentials
3. Configre the kube config file using the AWS cli
4. Use Helm to uninstall the app from the kubernetes namespace and use Helm to remove any remaining volumes and jobs
5. Add a comment to the PR to alert contributers that the environment is no longer available

## Miscellaneous Workflows

### Autoupdate

TODO
