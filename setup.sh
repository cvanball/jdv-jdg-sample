#!/bin/bash
oc login -u system:admin
oc delete -n openshift -f jboss-image-streams.json
oc create -n openshift -f jboss-image-streams.json
oc -n openshift import-image jboss-datavirt63-openshift --insecure=true
oc login -u developer -p developer
echo 'Creating a new project called churnprediction'
oc new-project churnprediction
echo 'Deploying churnprediction template with default values and JDV with JDG'
oc process -f churnprediction-template.json | oc create -f -