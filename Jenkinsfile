pipeline {
    agent any
    
    tools {
        maven 'Maven'
        jdk 'JDK-17'
    }
    
    environment {
        SONAR_TOKEN = credentials('squ_95c956813886dc3da70d9dc50b54c5bc20c1a155')
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
        
        stage('3. Lancer les tests unitaires avec JaCoCo') {
            steps {
                script {
                    echo 'Exécution des tests avec couverture de code...'
                    bat 'mvn test jacoco:report'
                }
            }
            post {
                always {
                    junit '/target/surefire-reports/*.xml'
                    jacoco(
                        execPattern: '/target/jacoco.exec',
                        classPattern: '/target/classes',
                        sourcePattern: '/src/main/java'
                    )
                }
            }
        }
        
        stage('4. Analyse SonarQube') {
            steps {
                echo 'Analyse de la qualité du code avec SonarQube...'

                // This fixes your issue
                withSonarQubeEnv('Sonar-Server') { 
                    bat """
                        mvn sonar:sonar ^
                        -Dsonar.projectKey=ecommerce-spring-boot ^
                        -Dsonar.projectName="Ecommerce Spring Boot" ^
                        -Dsonar.coverage.jacoco.xmlReportPaths=target/site/jacoco/jacoco.xml
                    """
                }
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