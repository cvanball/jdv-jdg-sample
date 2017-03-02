#!/bin/bash
oc login -u system:admin
oc delete -n openshift -f jboss-image-streams.json
oc create -n openshift -f jboss-image-streams.json
oc -n openshift import-image jboss-datavirt63-openshift --insecure=true
oc login -u developer -p developer
echo 'Creating a new project called ChurnPrediction'
oc new-project ChurnPrediction



echo 'Creating a service account and accompanying secret for use by the ChurnPrediction application'
oc create -f https://raw.githubusercontent.com/cvanball/coolstore-microservice/feature/issue-27/jdv-catalog-service/extensions/datavirt-app-secret.yaml
echo 'Add the role view to the service account under which the pod is running'
oc adm policy add-role-to-user view system:serviceaccount:coolstore:datavirt-service-account
echo 'Retrieving datasource properties (Product information from flatfile)'
curl https://raw.githubusercontent.com/cvanball/coolstore-microservice/feature/issue-27/jdv-catalog-service/extensions/datasources.properties -o datasources.properties
echo 'Creating a secret around the datasource properties'
oc secrets new datavirt-app-config datasources.properties
echo 'Deploying Coolstore template with default values and JDV'
oc process -f coolstore-template.yaml | oc create -f -