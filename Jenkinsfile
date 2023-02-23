pipeline {
     agent { dockerfile true }
     environment {
            CI = 'true'
        }
    stages {
        stage('Build') {
            steps {
                sh 'yarn install --ignore-engines'
            }
        }
        stage('Deliver') {
            steps {
                sh "chmod +x ./jenkins/scripts/deliver.sh" 
                sh './jenkins/scripts/deliver.sh'
                sh './jenksin/scripts/deploy.sh'
                input message: 'Finished using the web site? (Click "Proceed" to continue)'
                sh "chmod +x ./jenkins/scripts/kill.sh" 
            }
        }

    }
}