@Library('my-shared-library') _

pipeline {
  
  agent any

  parameters{
    string(name: 'DockerUser', description: "name of the dockerhub user", defaultValue: 'szadhub' )
    string(name: 'ImageTag', description: "tag of the docker build", defaultValue: env.BUILD_ID )
    string(name: 'AppName', description: "name of the app", defaultValue: 'java-app' )
    booleanParam(name: 'EnableTrivyScan', defaultValue: true, description: 'Enable Trivy Image Scan')
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



    stage('Trivy Image Scan') {
      when {
        expression {
          params.EnableTrivyScan == true
        }
      }
      steps {
        script {
          trivyScan("${params.DockerUser}", "${params.AppName}", "${params.ImageTag}")
        }
      }
    }
    stage('Checking if theres older previous build container running') {
      steps {
        script {
        containerCheck("${params.AppName}")
        }
      }
    }

    stage('Running the Application in container') {
      steps {
        script {
          runAppDocker("${params.AppName}", "${params.DockerUser}", "${params.ImageTag}")
        }
      }
    }
    
    stage('Validate the docker stop container') {
      when {
        beforeInput true
        expression {
          env.BRANCH_NAME != 'main'
        }
      }
        input {
          message 'Do you want to stop the app container?'
          ok 'ok'
        }
        steps {
          script {
            stopDockerContainer("${params.AppName}")
          }
        }   
    } 
  }
}