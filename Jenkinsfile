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
                sh './jenkins/scripts/deliver.sh'
                input message: 'Finished using the web site? (Click "Proceed" to continue)'
                sh './jenkins/scripts/kill.sh'
            }
        }

    }
}