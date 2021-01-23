#!/bin/bash

echo ======================================================================
echo ==========Build MuleSoft Time-Zone App to CloudHub US-East-1==========
echo ======================================================================

cd "D:\mule-workspace\timezone-app"
mvn clean
mvn install

echo ======================================================================
echo ========Deploying MuleSoft Time-Zone App to CloudHun US-East-1========
echo ======================================================================

anypoint-cli runtime-mgr cloudhub-application deploy --workers "1" --workerSize "0.1" --region "us-east-1" --objectStoreV1 "false" --runtime "4.3.0" --property "anypoint.platform.client_id:97e0e5662e3941adbe490bf5ad8b5834" --property "anypoint.platform.client_secret:1430aEA8F6864D0C92Bb8731A93131ca"  "timezone-app" "D:\mule-workspace\timezone-app\target\timezone-app-1.0.0-SNAPSHOT-mule-application.jar"

echo ======================================================================
echo ====================Call Anypoint Platform Login API==================
echo ======================================================================


token=$(curl -H "Content-Type: application/json" -X POST https://anypoint.mulesoft.com/accounts/login -d "{\"username\":\"Anypoint_Username\",\"password\":\"Anyoint_Password\"}" | jq .'access_token')
temp="${token%\"}"
temp="${temp#\"}"
echo "$temp"

echo ======================================================================
echo ==================Apply Rate Limiting Policy To APIs==================
echo ======================================================================

bearer="Authorization: Bearer "
authToken="$bearer$temp"
echo $authToken
curl -X POST https://anypoint.mulesoft.com/apimanager/api/v1/organizations/567436ed-a889-4vf0-9714-8acdffda18f22/environments/665b98a-01a9-40458-8b53-45fa47e567/apis/1672395/policies -H "$authToken" -H "content-type: application/json" -d "{\"configurationData\":{\"rateLimits\":[{\"timePeriodInMilliseconds\":60000,\"maximumRequests\":100}],\"clusterizable\":true,\"exposeHeaders\":false},\"policyTemplateId\":\"rate-limiting\",\"assetId\":\"rate-limiting\",\"assetVersion\":\"1.3.3\", \"groupId\":\"68ef9520-24e9-4cf2-b2f5-620025690913\"}"

echo ======================================================================
echo ======================Fetch Policies Details==========================
echo ======================================================================

curl -X GET https://anypoint.mulesoft.com/apimanager/api/v1/organizations/567436ed-a889-4vf0-9714-8acdffda18f22/environments/665b98a-01a9-40458-8b53-45fa47e567/apis/1672395/policies -H "$authToken" -H "content-type: application/json"

echo ======================================================================
echo ===========MuleSoft Application Information - TimeZone App============
echo ======================================================================

anypoint-cli runtime-mgr cloudhub-application describe "timezone-app" -o json