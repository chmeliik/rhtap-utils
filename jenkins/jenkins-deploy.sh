#!/bin/bash

# WIP - This script do not work in some cases and you can run into this issue with Jenkins: https://access.redhat.com/solutions/6273801

# TODO: add wait for Jenkins deployment
oc new-project jenkins
oc new-build --name jenkins-agent-base  --binary=true --strategy=docker
oc start-build jenkins-agent-base --from-file=./jenkins-agent/Dockerfile --wait --follow
oc new-app -e JENKINS_PASSWORD=admin123 -e VOLUME_CAPACITY=10Gi jenkins-persistent 
oc apply -f ./jenkins-agent/jenkins-agent-base-scc.yml 
oc adm policy add-scc-to-user jenkins-agent-base -z jenkins
