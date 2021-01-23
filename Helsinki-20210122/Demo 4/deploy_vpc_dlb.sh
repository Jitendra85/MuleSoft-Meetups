#!/bin/bash

echo ======================================================================
echo ============Create Anypoint VPC in US-East-1 region===================
echo ======================================================================

anypoint-cli cloudhub vpc create "mule-demo-vpc" "us-east-1" "10.0.1.0/24"

echo ======================================================================
echo ==============Associate the Environment with VPC======================
echo ======================================================================
 
anypoint-cli cloudhub vpc environments add "mule-demo-vpc" "Production"

echo ======================================================================
echo =========Remove unwanted firewall rules associated with VPC==========
echo ======================================================================

anypoint-cli cloudhub vpc firewall-rules remove "mule-demo-vpc" "0"
anypoint-cli cloudhub vpc firewall-rules remove "mule-demo-vpc" "0"

echo ======================================================================
echo ===========Add New firewall rules associated with VPC=================
echo ======================================================================

anypoint-cli cloudhub vpc firewall-rules add "mule-demo-vpc" "10.0.1.0/24" "tcp" "8092"
anypoint-cli cloudhub vpc firewall-rules add "mule-demo-vpc" "10.0.1.0/24" "tcp" "8091"
anypoint-cli cloudhub vpc firewall-rules add "mule-demo-vpc" "0.0.0.0/0" "tcp" "8081"
anypoint-cli cloudhub vpc firewall-rules add "mule-demo-vpc" "0.0.0.0/0" "tcp" "8082"

echo ======================================================================
echo ==============Create Anypoint DLB within the VPC======================
echo ======================================================================

anypoint-cli cloudhub load-balancer create "mule-demo-vpc" "mule-demo-lb" "C:\Users\Desktop\Helsinki Meetup\Demo5\lb-demo-public.pem" "C:\Users\Desktop\Helsinki Meetup\Demo5\lb-demo-private.pem" --http "off"

echo ======================================================================
echo ================Add Mapping Rules Within DLB==========================
echo ====================================================================== 

anypoint-cli cloudhub load-balancer mappings add "mule-demo-lb" "1" "/{app}/" "org-{app}-{subdomain}" "/"

echo ======================================================================
echo ==================Fetch the VPC Details===============================
echo ====================================================================== 

anypoint-cli cloudhub vpc describe "mule-demo-vpc"

echo ======================================================================
echo ==================Fetch the DLB Details===============================
echo ====================================================================== 

anypoint-cli cloudhub load-balancer describe "mule-demo-lb"

 