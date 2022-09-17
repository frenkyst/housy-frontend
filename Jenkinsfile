def credential = 'menther'
def userdock = 'menther'
def server = 'menther@20.0.82.144'
def directory = 'housy-frontend'
def url = 'https://github.com/frenkyst/housy-frontend.git'
def branch = 'main'
def image = 'housy-frontend'

pipeline{
  agent any
  stages{
     stage('Pull From frontend Repo') {
         steps {
            sshagent([credential]) {
                sh """ssh -o StrictHostkeyChecking=no ${server} << EOF
                cd ${directory}
                git remote add origin ${url} || git remote set-url origin ${url}
                git pull ${url} ${branch}
                exit
                EOF"""
              }
          }
      }
      stage('Build Docker Image') {
            steps {
                sshagent([credential]) {
                   sh """ssh -l -o StrictHostkeyChecking=no ${server} <<EOF
                   cd ${directory}
                   docker build -t ${image}:latest 
                   exit
                   EOF"""                   
              }
          }
      }
      stage('building docker images'){
          steps{
              sshagent ([credential]) {
                  sh """ssh -o StrictHostkeyChecking=no ${server} << EOF
                  docker compose -f fe.yaml up -d
                  exit
                  EOF"""
              }
          }
      }
      stage('Push to Docker Hub') {
            steps {
                sshagent([credential]) {
            sh """ssh -o StrictHostkeyChecking=no ${server} << EOF
            docker tag ${userdock}-${image}:latest ${userdock}/${image}:latest
            docker image push ${userdock}/${image}:latest
            exit
            EOF"""
          }
      }
      }
  }

}
