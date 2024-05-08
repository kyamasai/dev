pipeline {
   agent any
     stages {
       stage ("clone the repository") {
         steps {
           git branch: 'pushing-docker-image-to-dockerhub-jenkinsfile', credentialsId: 'git-credentials', url: 'https://github.com/techworldwithmurali/java-application.git'
             
         }
       }

          stage  ('bulid the repository') {
             steps {
               sh 'mvn clean install'
                 
             }
          }

          stage ('build the docker image') {
             steps {
               sh '''
                 docker build . -t ksai1999/web-application:latest
                   docker tag web-appication:latest ksai1999/web-application:latest
                  '''
             }
            
          }

          stage ('push the docker image') {
            steps {
              withCredentials([usernamePassword(credentialsId: 'docker-credentials', passwordVariable: 'DOCKERHUB_PASSWORD', usernameVariable: 'DOCKERHUB_USERNAME')]) {
    // some block
                
             sh '''
               docker login -u $DOCKERHUB_USERNAME -p $DOCKERHUB_PASSWORD
                
}
            }
          }
     
     }


  
}

