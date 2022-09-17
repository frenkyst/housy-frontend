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
     stage('Pull From Frontend Repo') {
         steps {
            sshagent([credential]) {
                sh """ssh -o StrictHostkeyChecking=no ${server} << EOF
                cd ${directory}
                # docker compose down
                docker system prune -f
                git remote add origin ${url} || git remote set-url origin ${url}
                git pull ${url} ${branch}
                exit
                EOF"""
              }
          }
      }
      stage('Building Docker Images'){
          steps{
              sshagent ([credential]) {
                  sh """ssh -o StrictHostkeyChecking=no ${server} << EOF
                  docker container stop ${userdock}-${image}
                  docker container rm ${userdock}-${image}
                  docker rmi ${userdock}/${image}
                  docker rmi ${userdock}-${image}
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
