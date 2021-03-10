#!/bin/bash

echo ======================================================================
echo ==========Build MuleSoft App to CloudHub US-East-1===================
echo ======================================================================

anypoint-cli runtime-mgr cloudhub-application deploy  "mule-cli-surat-demo" "C:\Users\Jitendra Bafna\Desktop\cli-demo-app1.jar" --workers "1" --workerSize "0.1" --runtime "4.3.0"  -objectStoreV1 false --region "us-east-1" --property  "anypoint.platform.client_id:97e0e5662e394834" --property "anypoint.platform.client93131ca"


echo ======================================================================
echo ==========Applying MuleSoft Policies==================================
echo ======================================================================
anypoint-cli api-mgr policy apply "16678994" "rate-limiting" --policyVersion "1.3.4" -c '{"configurationData":{"rateLimits":[{"timePeriodInMilliseconds":60000,"maximumRequests":100}],"clusterizable":true,"exposeHeaders":false},"policyTemplateId":"rate-limiting","assetId":"rate-limiting","assetVersion":"1.3.3","groupId":"68ef9520-24e9-4cf2-b2f5-620025690913"}'