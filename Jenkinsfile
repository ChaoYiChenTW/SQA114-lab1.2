pipeline {
  agent any
  environment {
    FIREBASE_DEPLOY_TOKEN = credentials('firebase-token')
    TEST_RESULT_FILE = 'test_result.txt'
  }  
  stages{
    stage('Building'){
        steps {
                sh 'sudo apt-get update'
                sh 'sudo apt-get install -y wget unzip'
                sh 'wget https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm'
                sh 'sudo yum install -y google-chrome-stable_current_x86_64.rpm'
                sh 'CHROME_VERSION=$(google-chrome --version | grep -oP "\d+\.\d+\.\d+\.\d+")'
                sh 'echo "Installed Google Chrome version: $CHROME_VERSION"'
                sh 'wget https://storage.googleapis.com/chrome-for-testing-public/$CHROME_VERSION/linux64/chromedriver-linux64.zip'
                sh 'unzip chromedriver-linux64.zip'
                sh 'sudo mv chromedriver /usr/local/bin/'
                sh 'sudo chmod +x /usr/local/bin/chromedriver'
                sh 'chromedriver --version'
            }
    }
    stage('Testing'){
        steps{
            sh 'firebase deploy -P testing-sqa113 --token "$FIREBASE_DEPLOY_TOKEN"' 
            script{
                try{                    
                    //Run the test and capture the output
                    def output = sh(script: 'pytest -v test', returnStdout: true).trim()

                    //Debugging printing the output
                    echo "Test Output: ${output}"

                    //Write the result to a file

                    if(output.contains('Test Success')){
                        writeFile file: env.TEST_RESULT_FILE, text: 'true'
                    }else{
                        writeFile file: env.TEST_RESULT_FILE, text: 'false'
                    }
                }catch (Exception e) {
                    echo "Test failed: ${e.message}"
                    writeFile file: env.TEST_RESULT_FILE, text: 'false'
                }
            }
            

        }
    }
    stage('Staging'){
        when{
               expression {
                 // Read the test result from the file id true continue
                def testResult = readFile(env.TEST_RESULT_FILE).trim()
                return testResult == 'true'
                }           
             }
        steps{
          sh 'firebase deploy -P staging-sqa113 --token "$FIREBASE_DEPLOY_TOKEN"'
        }
    }
    stage('Production'){
        when{
               expression {
                 // Read the test result from the file id true continue
                def testResult = readFile(env.TEST_RESULT_FILE).trim()
                return testResult == 'true'
                }           
             }
        steps{
               sh 'firebase deploy -P production-sqa113 --token "$FIREBASE_DEPLOY_TOKEN"'
        }
    }
  }
}