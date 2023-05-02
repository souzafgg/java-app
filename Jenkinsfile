@Library('my-shared-library') _

pipeline {
  
  agent any

  parameters{
    choice(name: 'action', choices: 'create\ndelete', description: 'Choose create/destroy')
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
  }
}