pipeline {
     agent { dockerfile true }
     environment {
            CI = 'true'
            // HEROKU_API_KEY = credentials('heroku-api-key')
            // IMAGE_NAME = 'jenkins-example-react'
            // IMAGE_TAG = 'latest'
            // APP_NAME = 'eli-auth-provider-router'
        }
    stages {
         stage('Build') {
            steps {
                sh 'yarn install --ignore-engines'
            }
        }
        stage('Deploy'){
            steps{
                sh 'git push heroku master '
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
}