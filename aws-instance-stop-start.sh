#!/bin/bash
#
# Version 1.0
# Creation date: 10/04/2017
# Written by: Rajkumar Sirikonda
# This Script will start and stop all AWS EC2 instances in a given VPC

##############################################
# Setting variables
##############################################
PATH="/usr/local/aws:/usr/local/aws/bin/:/usr/bin:/bin:/usr/sbin:/sbin";
DATE=`date '+%m%d%y'`;
VPCID="$2";
export PATH;

##############################################
# Check script syntax
##############################################
if [ "$#" -ne "2" ];
then
	echo $"Usage: $0 {start|stop} <VPC-ID>";
        exit 1;
fi


##############################################
# Main script starts here
##############################################

start() {
        # Start Instances.
	export PATH="/usr/local/aws:/usr/local/aws/bin/:/usr/bin:/bin:/usr/sbin:/sbin";
	INSTANCES=`aws ec2 describe-instances --filters Name="network-interface.vpc-id",Values="$VPCID" |grep InstanceId |awk -F\: '{print $2}' |awk '{gsub(/\"|\,/,"")}1'`;
	echo "Starting AWS Instances";
	echo " ";
	aws ec2 start-instances --instance-ids $INSTANCES --output text;
}

stop() {
        # Stop Instances.
	export PATH="/usr/local/aws:/usr/local/aws/bin/:/usr/bin:/bin:/usr/sbin:/sbin";
        INSTANCES=`aws ec2 describe-instances --filters Name="network-interface.vpc-id",Values="$VPCID" |grep InstanceId |awk -F\: '{print $2}' |awk '{gsub(/\"|\,/,"")}1'`;
        echo "Stopping AWS Instances";
	echo " ";
        aws ec2 stop-instances --instance-ids $INSTANCES --output text;
}

case "$1" in
  start)
        start
        ;;
  stop)
       stop 
        ;;
  *)
        echo $"Usage: $0 {start|stop} <VPC-ID>"
        exit 2
esac
