pipeline {
  agent any
  stages {
    stage('Build') {
      steps {
        build 'MazeRunner'
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