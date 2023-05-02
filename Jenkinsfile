@Library('my-shared-library') _

pipeline {
  
  agent any

  parameters{
    choice(name: 'action', choices: 'create\ndelete', description: 'Choose create/destroy')
  }

  stages {

    when { expression { param.action == 'create' }}

    stage('Git Checkout') {

          steps{
          gitCheckout(
            branch: "main",
            url: "https://github.com/souzafgg/java-app.git"
          )
          }
    }

    stage('Unit Test Maven') {

      when { expression { param.action == 'create' }}

      steps{
        script {

          mvnTest()

        }
      }
    }
  }
}