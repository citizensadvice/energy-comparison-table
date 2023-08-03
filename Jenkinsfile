#!/usr/bin/env groovy

node("docker && awsaccess") {

  checkout scm

  isPullRequest = env.CHANGE_TARGET != null
  isDeployment = !isPullRequest
  cdkContextArgs = "--ci --no-color"

  withAwsCdk("infrastructure", ["docker_args": "-v /var/run/docker.sock:/var/run/docker.sock"]) {
    stage("test") {
        sh "python -m pip install -r requirements.txt -r requirements-dev.txt"
    }

    stage("diff") {
      if (!isDeployment) {
        appendToPrBody(message: cdk("diff ${cdkContextArgs} 2>&1"))
      }
    }
  }
}
