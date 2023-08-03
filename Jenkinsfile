#!/usr/bin/env groovy
appName = 'energy-supplier-comparsion-tool'
dockerImageName = appName.toLowerCase()


@NonCPS
def dockerImageId() {
  "${dockerImageName}:${imageTagPrefix}${env.SAFE_BUILD_TAG}"
}

node("docker && awsaccess") {

  checkout scm

  isPullRequest = env.CHANGE_TARGET != null
  isDeployment = !isPullRequest
  cdkContextArgs = "--ci --no-color"

  isRelease = env.BRANCH_NAME == "main"
  imageTagPrefix = isRelease ? "" : "dev_"
  dockerImage = null

  setSafeBuildTag()

  stage("Build") {
    dockerImage = docker.build(dockerImageId())
  }

  stage("Lint") {
    dockerImage.inside {
      sh 'yarn run lint:scss'
      sh 'yarn run lint:js'
    }
  }

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
