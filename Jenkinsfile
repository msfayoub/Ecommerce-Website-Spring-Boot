pipeline {
    agent any
    
    tools {
        maven 'Maven'
        jdk 'JDK-17'
    }
    
    environment {
        SONAR_HOST_URL = 'http://localhost:9000'
        SONAR_TOKEN = credentials('squ_95c956813886dc3da70d9dc50b54c5bc20c1a155')
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
                script {
                    bat 'mvn test'
                }
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
                script {
                    withSonarQubeEnv('SonarQube') {
                        bat """
                            mvn sonar:sonar ^
                            -Dsonar.projectKey=ecommerce-website ^
                            -Dsonar.projectName="Ecommerce Website" ^
                            -Dsonar.host.url=%SONAR_HOST_URL% ^
                            -Dsonar.login=%SONAR_TOKEN%
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
        always {
            echo 'Nettoyage de l\'espace de travail...'
            // cleanWs() - Remove this or keep it inside node context
        }
        success {
            echo '✓ Le pipeline a réussi!'
        }
        failure {
            echo '✗ Le pipeline a échoué.'
        }
    }
}