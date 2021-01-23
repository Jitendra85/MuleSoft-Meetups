#!/bin/bash

echo ======================================================================
echo ====================Call Anypoint Platform Login API==================
echo ======================================================================

token=$(curl -H "Content-Type: application/json" -X POST https://anypoint.mulesoft.com/accounts/login -d "{\"username\":\"Anypoint_Username\",\"password\":\"Anypoint_Password\"}" | jq .'access_token')
temp="${token%\"}"
temp="${temp#\"}"
bearer="Authorization: Bearer "
authToken="$bearer$temp"
echo $authToken

echo ======================================================================
echo ====================Fetch Server Details==============================
echo ======================================================================

curl -H "Content-Type: application/json" -H "X-ANYPNT-ENV-ID: 665b98a-01a9-40458-8b53-45fa47e567" -H "X-ANYPNT-ORG-ID: 567436ed-a889-4vf0-9714-8acdffda18f22" -H "$authToken"  -X GET https://anypoint.mulesoft.com/hybrid/api/v1/servers 

echo ======================================================================
echo ====================Create Anypoint Cluster===========================
echo ======================================================================

curl -X POST https://anypoint.mulesoft.com/hybrid/api/v1/clusters -H "Content-Type: application/json" -H  "X-ANYPNT-ENV-ID: 665b98a-01a9-40458-8b53-45fa47e567" -H "X-ANYPNT-ORG-ID: 567436ed-a889-4vf0-9714-8acdffda18f22" -H "$authToken"  -d "{\"name\":\"mule-test-cluster\",\"multicastEnabled\":true,\"servers\":[{\"serverId\":5875129,\"serverIp\":\"192.169.44.18\"},{\"serverId\":5875134,\"serverIp\":\"192.169.44.18\"}]}"

echo ======================================================================
echo =====================Fetch Anypoint Cluster===========================
echo ======================================================================
curl -H "Content-Type: application/json" -H "X-ANYPNT-ENV-ID: 665b98a-01a9-40458-8b53-45fa47e567" -H "X-ANYPNT-ORG-ID: 567436ed-a889-4vf0-9714-8acdffda18f22" -H "$authToken"  -X GET https://anypoint.mulesoft.com/hybrid/api/v1/clusters 