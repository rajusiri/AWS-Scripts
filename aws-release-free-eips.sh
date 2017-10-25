#!/bin/bash
#
# Version 1.0
# Creation date: 10/05/2017
# Written by: Rajkumar Sirikonda
# This Script will release un-user/free AWS elastic public IPs 

##############################################
# Setting variables
##############################################
PATH="/usr/local/aws:/usr/local/aws/bin/:/usr/bin:/bin:/usr/sbin:/sbin";
DATE=`date '+%m%d%y'`;
export PATH;

##############################################
# Check script syntax
##############################################
if [ "$#" -ne "0" ];
then
        echo $"Usage: $0 ";
        exit 1;
fi


##############################################
# Main script starts here
##############################################
EIPALLOC=`aws ec2 describe-addresses --query 'Addresses[?AssociationId==null]' --output text |awk '{print $1}'`;
for AID in $EIPALLOC;
do
   #echo "Releasing AWS Elastic IP Assosiated to $AID";
   aws ec2 release-address --allocation-id $AID;
done
