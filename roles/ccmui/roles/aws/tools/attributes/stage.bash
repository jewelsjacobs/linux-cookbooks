#!/bin/bash -e

user='ec2-user'

master=''

slaves=(
    # us-east-1
    'ec2-54-236-248-129.compute-1.amazonaws.com'
    'ec2-54-210-28-195.compute-1.amazonaws.com'

    # eu-west-1
    'ec2-54-77-195-93.eu-west-1.compute.amazonaws.com'
    'ec2-54-77-124-10.eu-west-1.compute.amazonaws.com'

    # ap-northeast-1
    'ec2-54-64-209-41.ap-northeast-1.compute.amazonaws.com'
    'ec2-54-64-70-70.ap-northeast-1.compute.amazonaws.com'
)

identityFile='/Volumes/Data/Data/Keys/ssh/adobe/aws/ccmui/stage.pem'
