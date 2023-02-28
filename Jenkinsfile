pipeline {
     agent any
     environment {
            CI = 'true'
            HEROKU_API_KEY = credentials('heroku-api-key')
            IMAGE_NAME = 'elihood/jenkins-example-react'
            IMAGE_TAG = 'latest'
            APP_NAME = 'eli-auth-provider-router'
        }
    stages {
        stage('Build') {
            steps {
                sh 'yarn install'
                sh 'docker build -t $IMAGE_NAME:$IMAGE_TAG .'
            }
        }
        stage('Login') {
            steps {
                sh 'echo $HEROKU_API_KEY | docker login --username=_ --password-stdin registry.heroku.com'
            }
        }
        stage('Deliver') {
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
                    docker run sineverba/heroku-cli echo $HEROKU_API_KEY | heroku container:release web --app=$APP_NAME     
                '''
            }
        }

    }
      post {
            always {
                sh 'docker logout'
                sh "chmod +x ./jenkins/scripts/deliver.sh" 
                sh './jenkins/scripts/deliver.sh'
                input message: 'Finished using the web site? (Click "Proceed" to continue)'
                sh "chmod +x ./jenkins/scripts/kill.sh" 
            }
        }
}