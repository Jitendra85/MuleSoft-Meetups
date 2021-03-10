#!/bin/bash

echo ======================================================================
echo ==========Setup Anypoint Clustering===================================
echo ======================================================================


anypoint-cli runtime-mgr cluster create "mule-demo-cluster" --multicast --server "6463314:192.168.1.104" --server "6463322:192.168.1.101"


