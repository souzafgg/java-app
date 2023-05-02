@Library('my-shared-library') _

pipeline {
  
  agent any

  parameters{
    string(name: 'DockerUser', description: "name of the dockerhub user", defaultValue: 'szadhub' )
    string(name: 'ImageTag', description: "tag of the docker build", defaultValue: env.BUILD_ID )
    string(name: 'AppName', description: "name of the app", defaultValue: 'java-app' )
  }

  stages {

    

    stage('Git Checkout') {

  
          steps{
          gitCheckout(
            branch: "main",
            url: "https://github.com/souzafgg/java-app.git"
          )
          }
    }

    stage('Unit Test Maven') {

      steps{
        script {
          mvnTest()

        }
      }
    }

    stage('Integration Test Maven') {

      steps{
        script{
          mvnIntegrationTest()

        }
      }
    }

    stage('Static code analysis with Sonarqube') {
      steps {
        script {
          def sonar = 'sonar'
          codeAnalyses(sonar)
        }
      }
    }

    stage('Quality Gate') {
      steps {
        script {
          def sonar = 'sonar'
          QualityGate(sonar)
        }
      }
    }

    stage('Maven Build') {
      steps {
        script {
          mvnBuild()
        }
      }
    }

    stage('Docker Build') {
      steps {
        script {
          dockerBuild("${params.DockerUser}", "${params.AppName}", "${params.ImageTag}")
        }
      }
    }

    stage('Push to Docker Hub') {
      steps {
        script {
          buildToDockerHub("${params.DockerUser}", "${params.AppName}", "${params.ImageTag}")
        }
      }
    }

    stage('Validate Trivy Image Scan') {
      when {
        beforeInput true
        expression { env.BRANCH.NAME == 'main' }
      }
      input {
        message 'Do you want to apply the image Trivy Scan?'
        ok 'ok'
      }
    

    stage('Trivy Image Scan') {
      steps {
        script {
          trivyScan("${params.DockerUser}", "${params.AppName}", "${params.ImageTag}")
        }
      }
    }
    }
  }
}