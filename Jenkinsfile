pipeline {
  agent { dockerfile true }
  options {
    buildDiscarder(logRotator(numToKeepStr: '5'))
  }
  environment {
    HEROKU_API_KEY = credentials('heroku-api-key')
    IMAGE_NAME = 'jenkins-example-react'
    IMAGE_TAG = 'latest'
    APP_NAME = 'eli-auth-provider-router'
  }
  stages {
    stage('Build') {
      steps {
        sh 'yarn install --ignore-engines'
        sh 'docker build -t $IMAGE_NAME:$IMAGE_TAG .'
      }
    }
    stage('Login') {
      steps {
        sh 'echo $HEROKU_API_KEY | docker login --username=_ --password-stdin registry.heroku.com'
      }
    }
    stage('Push to Heroku registry') {
      steps {
        sh '''
          docker tag $IMAGE_NAME:$IMAGE_TAG registry.heroku.com/$APP_NAME/web
          docker push registry.heroku.com/$APP_NAME/web
        '''
      }
    }
    stage('Release the image') {
      steps {
        sh '''
          heroku container:release web --app=$APP_NAME
        '''
      }
    }
    stage('Deliver') {
        steps {
            sh "chmod +x ./jenkins/scripts/deliver.sh" 
            sh './jenkins/scripts/deliver.sh'
            input message: 'Finished using the web site? (Click "Proceed" to continue)'
            sh "chmod +x ./jenkins/scripts/kill.sh" 
        }
    }
  }
  post {
    always {
      sh 'docker logout'
    }
  }
}