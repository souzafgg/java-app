@Library('my-shared-library') _

pipeline {
  
  agent any

  parameters{
    choice(name: 'action', choices: 'create\ndelete', description: 'Choose create/destroy')
    string(name: 'DockerUser', description: "name of the dockerhub user", defaultValue: 'szadhub' )
    string(name: 'ImageTag', description: "tag of the docker build", defaultValue: env.BUILD_ID )
    string(name: 'AppName', description: "name of the app", defaultValue: 'java-app' )
  }

  stages {

    

    stage('Git Checkout') {

          when { expression { params.action == 'create' }}
          steps{
          gitCheckout(
            branch: "main",
            url: "https://github.com/souzafgg/java-app.git"
          )
          }
    }

    stage('Unit Test Maven') {

      when { expression { params.action == 'create' }}
      steps{
        script {
          mvnTest()

        }
      }
    }

    stage('Integration Test Maven') {

      when { expression { params.action == 'create' }}
      steps{
        script{
          mvnIntegrationTest()

        }
      }
    }

    stage('Static code analysis with Sonarqube') {
      when { expression { params.action == 'create' }}
      steps {
        script {
          def sonar = 'sonar'
          codeAnalyses(sonar)
        }
      }
    }

    stage('Quality Gate') {
      when { expression { params.action == 'create' }}
      steps {
        script {
          def sonar = 'sonar'
          QualityGate(sonar)
        }
      }
    }

    stage('Maven Build') {
      when { expression { params.action == 'create' }}
      steps {
        script {
          mvnBuild()
        }
      }
    }

    stage('Docker Build') {
      when { expression { params.action == 'create' }}
      steps {
        script {
          dockerBuild("${params.DockerUser}", "${params.AppName}", "${params.ImageTag}")
        }
      }
    }

    stage('Push to Docker Hub') {
      when { expression { params.action == 'create' }}
      steps {
        script {
          buildToDockerHub()
        }
      }
    }
  }
}