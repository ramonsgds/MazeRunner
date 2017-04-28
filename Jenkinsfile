pipeline {
  agent any
  stages {
    stage('Build') {
      steps {
        build 'MazeRunnerCD'
      }
    }
    stage('Test results') {
      steps {
        junit 'test-reports/*.xml'
      }
    }
    stage('Deploy') {
      steps {
        echo 'Deployed!!!'
      }
    }
  }
}