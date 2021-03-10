#!/bin/bash

echo ======================================================================
echo ==========Create VPC in us-east-1 region==============================
echo ======================================================================

anypoint-cli cloudhub vpc create "mule-demo-vpc" "us-east-1" "10.0.1.0/24" 


echo ======================================================================
echo ==========Associate Environment With VPC==============================
echo ======================================================================

anypoint-cli cloudhub vpc environments add "mule-demo-vpc" "Production"

echo ======================================================================
echo ==========Add Firewall Rule Within VPC================================
echo ======================================================================

anypoint-cli cloudhub vpc firewall-rules add "mule-demo-vpc"  "0.0.0.0/0" "tcp" "8081"
anypoint-cli cloudhub vpc firewall-rules add "mule-demo-vpc"  "0.0.0.0/0" "tcp" "8082"
anypoint-cli cloudhub vpc firewall-rules add "mule-demo-vpc"  "10.0.1.0/24" "tcp" "8091"
anypoint-cli cloudhub vpc firewall-rules add "mule-demo-vpc"  "10.0.1.0/24" "tcp" "8092"

echo ======================================================================
echo ==========Create Dedicated Load Balancer==============================
echo ======================================================================

anypoint-cli cloudhub load-balancer create "mule-demo-vpc" "mule-demo-dlb" "C:\Certificates\test-public-crt.pem" "C:\Certificates\test-private.pem" --http "off"