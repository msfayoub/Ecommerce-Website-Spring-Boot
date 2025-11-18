pipeline {
    agent any
    
    tools {
        maven 'Maven'
        jdk 'JDK-17'
    }
    
    environment {
        SONAR_HOST_URL = 'http://localhost:9000'
    }
    
    stages {
        stage('1. Checkout Code') {
            steps {
                git branch: 'master',
                    url: 'https://github.com/msfayoub/Ecommerce-Website-Spring-Boot.git'
            }
        }
        
        stage('2. Build Maven') {
            steps {
                bat 'mvn clean install -DskipTests'
            }
        }
        
        stage('3. Run Tests') {
            steps {
                bat 'mvn test'
            }
            post {
                always {
                    junit '**/target/surefire-reports/*.xml'
                    jacoco()
                }
            }
        }
        
        stage('4. Analyse SonarQube') {
            steps {
                withCredentials([string(credentialsId: 'sonar-token', variable: 'SONAR_TOKEN')]) {
                    withSonarQubeEnv('SonarQube') {
                        bat """
                            mvn sonar:sonar ^
                            -Dsonar.projectKey=ecommerce-website ^
                            -Dsonar.projectName="Ecommerce Website" ^
                            -Dsonar.host.url=%SONAR_HOST_URL% ^
                            -Dsonar.token=%SONAR_TOKEN%
                        """
                    }
                }
            }
        }
        
        stage('5. Générer le package JAR') {
            steps {
                bat 'mvn package -DskipTests'
            }
        }
    }
    
    post {
        success {
            echo '✓ Le pipeline a réussi!'
        }
        failure {
            echo '✗ Le pipeline a échoué.'
        }
    }
}