#!/usr/bin/env groovy

node("docker && awsaccess") {

  checkout scm

  isPullRequest = env.CHANGE_TARGET != null
  isDeployment = !isPullRequest
  cdkContextArgs = "--ci --no-color"

  withAwsCdk("infrastructure", ["docker_args": "-v /var/run/docker.sock:/var/run/docker.sock"]) {
    stage("test") {
        sh "python -m pip install -r requirements.txt -r requirements-dev.txt"
        sh "python -m pytest --junitxml results.xml"
        junit allowEmptyResults: true, checksName: 'AWS CDK tests', skipMarkingBuildUnstable: true, testResults: 'results.xml'
    }

    stage("diff") {
      if (!isDeployment) {
        appendToPrBody(message: cdk("diff ${cdkContextArgs} 2>&1"))
      }
    }

    stage("deploy") {
      if (isDeployment) {
        cdk "deploy ${cdkContextArgs} --all --require-approval never --concurrency 2 --outputs-file outputs.json"
        // make the outputs accessible via the Jenkins UI. Useful for retrieving e.g endpoints
        archiveArtifacts artifacts: 'outputs.json', allowEmptyArchive: true
      } else {
        echo "PRs are not deployed."
      }
    }
  }
}
