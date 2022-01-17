#!/usr/bin/env groovy
@Library('OGJenkinsLib@git-caching') _

def scmVars
def tags
def containers = [
  OGContainer('jdk', 'openjdk', '11.0.9', [
    environmentVariables: [JAVA_OPTS: '-XshowSettings:vm'],
    resourceLimitCpu: '3000m',
    resourceLimitMemory: '5.0Gi']
  ),

  OGContainer('postgres', 'postgres', '9.6', [
    command: null, // To use the default command
    environmentVariables: [POSTGRES_PASSWORD: 'postgres'],
    resourceLimitCpu: '500m',
    resourceLimitMemory: '512Mi']
  ),

  OGContainer('mongo', 'mongo', '3.6-stretch', [
    command: null,
    resourceLimitCpu: '500m',
    resourceLimitMemory: '512Mi']
  ),

  OGContainer('dynamodb', 'amazon/dynamodb-local', '1.17.2', [
    command: null,
    resourceLimitCpu: '500m',
    resourceLimitMemory: '512Mi'
  ])
]

// The container tag that shall be used for when the Git branch name contains a `/`
def branchTagFriendly

OGAgentPipeline(containers) {
  stage('Setup') {
    scmVars = checkout scm
      }

  stage('SonarQube Analysis') {
     container('sonarscanner') {
    def scannerHome = tool 'SonarScanner';
    if ( params.SERVICE_NAME == "budget-gateway-service" ) {  
      withSonarQubeEnv() {
        sh "${scannerHome}/bin/sonar-scanner -Dsonar.projectBaseDir=${params.GRADLE_SETTINGS_PATH}/${params.SERVICE_NAME}/"
      }
    }  
  }
  } // stage('Build Jar')


} // OGAgentPipeline(containers)
