
pipeline{
    tools{
        jdk 'java1.8'
        maven 'maven'
    }
     agent any

     stages{
	  def application = "myproject2app"
     	  def dockerhubaccountid = "chinmay8292"
	     
          stage('Checkout'){
               steps{
		 echo 'cloning..'
                 git 'https://github.com/Sonal0409/DevOpsClassCodes.git'
              }
          }
          stage('Compile'){
              steps{
                  echo 'compiling..'
                  sh 'mvn compile'
	      }
          }
          stage('CodeReview'){
              steps{
		  echo 'codeReview'
                  sh 'mvn pmd:pmd'
              }
          }
          stage('UnitTest'){	  
              steps{
	         echo 'Testing'
                  sh 'mvn test'
              }
               post {
               		success {
                   		junit 'target/surefire-reports/*.xml'
               		}
           	}	
          }
          stage('MetricCheck'){    
              steps{
                  sh 'mvn cobertura:cobertura -Dcobertura.report.format=xml'
              }
          }
          stage('Package'){  
              steps{
                  sh 'mvn package'
              }
          }
	  stage('Build image') {
	 	steps{
			 app = docker.build("${dockerhubaccountid}/${application}:${BUILD_NUMBER}")
		 }
	  }	
	 stage('Push image') {
		 steps{
			withDockerRegistry([ credentialsId: "dockerHub", url: "" ]) {
				app.push()
				app.push("latest")
			}
		}
	  }
	 stage('Deploy') {
		 steps{
			 sh ("docker run -d -p 81:8080 -v /var/log/:/var/log/ ${dockerhubaccountid}/${application}:${BUILD_NUMBER}")
		 }
	  }
	 stage('Remove old images') {
		 steps{
			 // remove docker pld images
			 sh("docker rmi ${dockerhubaccountid}/${application}:latest -f")\
		 }
	 }
      }
}
