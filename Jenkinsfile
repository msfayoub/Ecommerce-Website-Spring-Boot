pipeline{
    agent any

    tools {
        maven 'Maven'
        jdk 'JDK-17'
    }

    environment {
        MAVEN_OPTS = '-Xmx1024m'
    }

    stages {
        stage('1. Cloner le repo') {
            steps {
                echo 'Clonage du repository depuis GitHub...'
                checkout scm
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
                echo 'Exécution des tests unitaires...'
                bat 'mvn test -DfailIfNoTests=false -Dmaven.test.failure.ignore=true'
            }
            post {
                always {
                    junit allowEmptyResults: true, testResults: '**/target/surefire-reports/*.xml'
                }
            }
        }

        stage('4. Générer le package WAR/JAR') {
            steps {
                echo 'Génération du package...'
                bat 'mvn package -DskipTests'
            }
            post {
                success {
                    archiveArtifacts artifacts: '**/target/*.jar', allowEmptyArchive: true, fingerprint: true
                }
            }
        }
    }

    post {
        always {
            echo 'Nettoyage de l\'espace de travail...'
            cleanWs()
        }
        success {
            echo '✓ Le pipeline a réussi.'
        }
        failure {
            echo '✗ Le pipeline a échoué.'
        }
    }
}