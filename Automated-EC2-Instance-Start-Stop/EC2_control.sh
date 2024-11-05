#!/bin/bash

#Usage: ./ec2_control.sh <instance-id> <start|stop>

INSTANCE_ID=$1
ACTION=$2

#Validate input
if [ -z "$INSTANCE_ID" ] || [ -z "$ACTION" ]; then
    echo "Usage: $0 <instance-id> <start|stop>"
        exit 1
        fi

        # Start or stop the instance based on action
        if [ "$ACTION" == "start" ]; then
        echo "Starting instance $INSTANCE_ID..."
        /usr/local/bin/aws ec2 start-instances --instance-ids "$INSTANCE_ID"
        elif [ "$ACTION" == "stop" ]; then
        echo "Stopping instance $INSTANCE_ID..."
        /usr/local/bin/aws ec2 stop-instances --instance-ids "$INSTANCE_ID"
        else
        echo "Invalid action: $ACTION. Use 'start' or 'stop'."
        exit 1
        fi
