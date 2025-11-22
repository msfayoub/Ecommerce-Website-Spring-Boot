pipeline {
    agent any

    tools {
        maven 'Maven'
        jdk 'JDK-17'
    }

    stages {
        stage('1. Checkout') {
            steps {
                checkout scm
            }
        }

        stage('2. Build') {
            steps {
                bat 'mvn clean install -DskipTests'
            }
        }

        stage('3. Test') {
            steps {
                bat 'mvn test'
            }
            post {
                always {
                    junit '**/target/surefire-reports/*.xml'
                }
            }
        }

        stage('4. Package') {
            steps {
                bat 'mvn package -DskipTests'
            }
        }

        stage('5. SonarQube Analysis') {
            steps {
                script {
                    withSonarQubeEnv('SonarQube') {
                        bat 'mvn sonar:sonar -Dsonar.projectKey=ecommerce-website -Dsonar.token=squ_95c956813886dc3da70d9dc50b54c5bc20c1a155'
                    }
                }
            }
        }
    }

    post {
        success {
            echo '✓ Pipeline succeeded!'
            archiveArtifacts artifacts: '**/target/*.jar', fingerprint: true
        }
        failure {
            echo '✗ Pipeline failed!'
        }
    }
}