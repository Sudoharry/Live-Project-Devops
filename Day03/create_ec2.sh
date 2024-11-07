#!/bin/bash

set -euo pipefail

check_awscli() {
    if ! command -v aws &> /dev/null; then
        echo "AWS CLI is not installed. Please install it first." >&2
        exit 1
    fi
}

install_awscli() {
    echo "Installing AWS CLI v2 on Linux..."

    # Download and install AWS CLI v2
    curl -s "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
    sudo apt-get install -y unzip &> /dev/null
    unzip -q awscliv2.zip
    sudo ./aws/install

    # Verify installation
    aws --version

    # Clean up
    rm -rf awscliv2.zip ./aws
}

wait_for_instance() {
    local instance_id="$1"
    echo "Waiting for instance $instance_id to be in running state..."

    local max_attemps=30
    local attempts=0

    while true; do
        state=$(aws ec2 describe-instances --instance-ids "$instance_id" --query 'Reservations[0].Instances[0].State.Name' --output text)
        if [[ "$state" == "running" ]]; then
            echo "Instance $instance_id is now running."
            break
        fi
	((attempts++))
	if (( attempts >= max_attempts )); then
		echo "Timeout waiting for instance $instance_id to be in runnning state." >&2
		exit 1
	fi	
        sleep 10
    done
}
    #Functions to check for already existing EC2 Instance within the system.
    check_existing_instance() {
    local instance_name="$1"
    echo "Checking if an instance with the name '$instance_name' already exists..."

    # Query existing instances
      existing_instance_id=$(aws ec2 describe-instances \
        --filters "Name=tag:Name,Values=$instance_name" \
        "Name=instance-state-name,Values=pending,running" \
        --query 'Reservations[*].Instances[*].InstanceId' \
        --output text)
    
     if [[ -n "$existing_instance_id" ]]; then
       echo "An instance with the name '$instance_name' already exists: $existing_instance_id"
       echo "Skipping creation of a new instance."
       exit 0
    else

      echo "No existing instance with the name '$instance_name' found."
     
     fi

   }
   
    #Functions to create new EC2 instance.
    create_ec2_instance() {
     local ami_id="$1"
     local instance_type="$2"
     local key_name="$3"
     local subnet_id="$4"
     local security_group_ids="$5"
     local instance_name="$6"

      # Check if an instance with the same name already exits
        check_existing_instance "$instance_name"
    
    # Run AWS CLI command to create EC2 instance
    instance_id=$(aws ec2 run-instances \
        --image-id "$ami_id" \
        --instance-type "$instance_type" \
        --key-name "$key_name" \
        --subnet-id "$subnet_id" \
        --security-group-ids "$security_group_ids" \
        --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$instance_name}]" \
        --query 'Instances[0].InstanceId' \
        --output text
    )

    if [[ -z "$instance_id" ]]; then
        echo "Failed to create EC2 instance." >&2
        exit 1
    fi

    echo "Instance $instance_id created successfully."

    # Wait for the instance to be in running state
    wait_for_instance "$instance_id"
}

main() {
    check_awscli || install_awscli

    echo "Creating EC2 instance..."

    # Specify the parameters for creating the EC2 instance
    AMI_ID="ami-0dee22c13ea7a9a67"
    INSTANCE_TYPE="t2.micro"
    KEY_NAME="harryb"
    SUBNET_ID="subnet-0d00acbc704f9d27d"
    SECURITY_GROUP_IDS="sg-0b0a9c38fcc7e30d1"  # Add your security group IDs separated by space
    INSTANCE_NAME="devops-day-11"


    #Validate the parameters
    if [[ -z "$AMI_ID" || -z "$KEY_NAME" || -z "$SUBNET_ID" || -z "$SECURITY_GROUP_IDS" ]]; then
	    echo "Error: One or more required parameters are missing." >&2 
	    exit 1	
    fi

    # Call the function to create the EC2 instance
    create_ec2_instance "$AMI_ID" "$INSTANCE_TYPE" "$KEY_NAME" "$SUBNET_ID" "$SECURITY_GROUP_IDS" "$INSTANCE_NAME"

    echo "EC2 instance creation completed."
}

main "$@"
