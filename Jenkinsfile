pipeline {
    agent any
    
    tools {
        maven 'Maven 3.9.9'
        jdk 'JDK 17'
    }
    
    environment {
        SONAR_TOKEN = 'squ_95c956813886dc3da70d9dc50b54c5bc20c1a155' // Replace with your token
    }
    
    stages {
        stage('1. Cloner le repo') {
            steps {
                script {
                    echo 'Clonage du repository depuis GitHub...'
                    checkout scm
                }
            }
        }
        
        stage('2. Compiler le projet') {
            steps {
                echo 'Compilation du projet Maven...'
                bat 'mvn clean compile'
            }
        }
        
        stage('3. Lancer les tests unitaires') {
            steps {
                script {
                    echo 'Exécution des tests unitaires...'
                    bat 'mvn test -DfailIfNoTests=false -Dmaven.test.failure.ignore=true'
                }
            }
            post {
                always {
                    junit '**/target/surefire-reports/*.xml'
                }
            }
        }
        
        stage('4. Analyse SonarQube') {
            steps {
                echo 'Analyse de la qualité du code avec SonarQube...'
                bat """
                    mvn sonar:sonar ^
                    -Dsonar.projectKey=ecommerce-spring-boot ^
                    -Dsonar.projectName="Ecommerce Spring Boot" ^
                    -Dsonar.host.url=http://localhost:9000 ^
                    -Dsonar.token=%SONAR_TOKEN%
                """
            }
        }
        
        stage('5. Générer le package JAR') {
            steps {
                echo 'Génération du package JAR...'
                bat 'mvn package -DskipTests'
            }
        }
    }
    
    post {
        success {
            echo '✓ Le pipeline s\'est terminé avec succès.'
        }
        failure {
            echo '✗ Le pipeline a échoué.'
        }
        always {
            echo 'Nettoyage de l\'espace de travail...'
            cleanWs()
        }
    }
}