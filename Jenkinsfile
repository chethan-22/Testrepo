pipeline {
  agent any

  options {
    timeout(time: 80, unit: 'MINUTES')
    disableConcurrentBuilds()
    preserveStashes(buildCount: 1)
    buildDiscarder(
      logRotator(
        numToKeepStr: '10',
        daysToKeepStr: '14',
        artifactDaysToKeepStr: '-1',
        artifactNumToKeepStr: '1'
      )
    )
  }

  environment {
    AFTER_ALL_HOOK="ci/Jenkinsfile-after-all"
    BEFORE_ALL_HOOK="ci/Jenkinsfile-before-all"
    BEFORE_CLOUD_BUILD_HOOK="ci/Jenkinsfile-before-cloud-build"
    BEFORE_CLOUD_DEPLOY_HOOK="ci/Jenkinsfile-before-cloud-deploy"
    POST_ALWAYS_HOOK="ci/Jenkinsfile-post-always"
    LFR_CREDS = credentials('liferay-com')
    SERVICE_CREDS = credentials('liferay-cloud')
  }

  triggers {
    githubPush()
  }

  stages {
    stage('Replacing Placeholders') {
      steps {
        script {
          sh """
          sed -i 's/NPM_TOKEN/${NPM_TOKEN}/g' liferay/modules/efuels-estimator/.npmrc
          cat liferay/modules/efuels-estimator/.npmrc
          """
        }
      }
    }
    stage('Compile Liferay Workspace') {
      steps {
        script {
          stashBuildMetadataJSON(["GIT_COMMIT": env.GIT_COMMIT])
        }

        reserveBuildNumber()

        createCiActivity('CI_STARTED')

        script {
          if (fileExists(env.BEFORE_ALL_HOOK)) {
            load env.BEFORE_ALL_HOOK
          }
        }

        cleanProject()

        lock('compileWorkspace') {
          compileWorkspace()
        }
  
      }
    }
    stage('Create DXP Cloud Build') {
      steps {
        script {
          if (fileExists(env.BEFORE_CLOUD_BUILD_HOOK)) {
            load env.BEFORE_CLOUD_BUILD_HOOK
          }
        }
        lock('createOrDeployBuild') {
          createDXPCBuild()
        }
      }
    }
    stage('Deploy to Cloud') {
      steps {
        script {
          if (fileExists(env.BEFORE_CLOUD_DEPLOY_HOOK)) {
            load env.BEFORE_CLOUD_DEPLOY_HOOK
          }

          lock('createOrDeployBuild') {
            deployToCloud(deployBranch: env.LCP_CI_DEPLOY_BRANCH, deployTarget: env.LCP_CI_DEPLOY_TARGET)
          }

          if (fileExists(env.AFTER_ALL_HOOK)) {
            load env.AFTER_ALL_HOOK
          }
        }
      }
    }
  }
  post {
    always {
      script {
        if (fileExists(env.POST_ALWAYS_HOOK)) {
          load env.POST_ALWAYS_HOOK
        }
      }
    }
    cleanup {
      cleanWs()
    }
    success {
      createCiActivity('CI_SUCCEEDED')
    }
    unsuccessful {
      createCiActivity('CI_FAILED')
    }
  }
}
