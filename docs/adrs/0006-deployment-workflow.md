# 6. Deployment workflow

Date: 2023-09-12

## Status

Accepted

## Context

The app is separate from the public website app and has no additional infrastructure requirements like a redis cache or postgres database. We need to decide on the app's testing and deployment workflow.

Content Platform production deployments are slow and laborious. They take an hour, and we have to manually review infrastructure changes, so we only run them twice a week. This makes it hard to fix bugs quickly, and we need code freezes around major launches to avoid deploying too much at once. We're really keen to avoid those problems in new apps, and we plan to fix them in existing apps.

## Decisions

### Continuous Integration / Continuous Deployment Workflow

Follow this workflow for development and deployments, which is expected to take around 15-20 mins from PR merge to production:

- pull main, branch, make changes, raise PR
  - linting / unit rests run using existing `lint-and-test` github workflow in this repo
  - feature tests are using Capybara and the docker image, like they are in the [smart meter tool](https://github.com/citizensadvice/smart-meter-tool/blob/f29c7f018361152f6dcf9a46de21b145de7df551/Jenkinsfile#L64) (this means we don't need to wait for the review app DNS to propagate)
  - optional: add review app label and manually sense check review app for confidence if required
- merge to main
  - deploys to `qa` environment
  - feature tests run again on `qa`
- automatic deployment to prod (assuming all tests pass)
- run smoke tests on prod

### Environments

Keep the `qa` environment that exists on [https://energy-comparison-table.qa.citizensadvice.org.uk/](https://energy-comparison-table.qa.citizensadvice.org.uk/). The `qa` environment will be used as a place to run feature tests once a PR has been merged.

If we didn't have this environment, we would need to run feature and smoke tests in the review app environments. Review apps take around 15 - 20 minutes for DNS changes to propagate and become usable, which is too long to wait if we need to make an urgent change and introduces a long feedback delay into the CI/CD pipeline.

### Review apps

Amend review apps so they can communicate with Contentful, so they can be used as an optional sanity checking environment before merging to `main`.

## Consequences

### Positive

- allow manual sanity checking before deployment
- does not require review app to be created if we need to make a quick deployment to prod
- no manual intervention required between code approval and deployment production environment

### Negative

- keeping the `qa` environment and the review apps is a workaround to avoid incorporating the DNS propagation time into the CI/CD pipeline. If there is a way to prepare the review app domains in advance or otherwise remove the wait time, we could run all the tests in the review app environments and remove the `qa` environments
