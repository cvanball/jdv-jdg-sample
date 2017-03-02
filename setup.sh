#!/bin/bash
oc login -u system:admin
oc delete -n openshift -f jboss-image-streams.json
oc create -n openshift -f jboss-image-streams.json
oc -n openshift import-image jboss-datavirt63-openshift --insecure=true
oc -n openshift import-image jboss-datagrid65-openshift --insecure=true
oc login -u developer -p developer
echo 'Creating a new project called churnprediction'
oc new-project churnprediction
echo 'Creating a service account and accompanying secret for use by the datavirt application'
oc create -f datavirt-app-secret.yaml
oc secret new resourceadapters-secret resourceadapters.properties
oc secret new configure-secret postconfigure.sh
echo 'Add the role view to the service account under which the pod is running'
oc adm policy add-role-to-user view system:serviceaccount:churnprediction:datavirt-service-account
echo 'Deploying churnprediction template with default values and JDV with JDG'
oc process -f churnprediction-template.json | oc create -f -
