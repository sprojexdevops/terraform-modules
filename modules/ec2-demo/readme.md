# Terraform AWS EC2

## Arguments
ami_id - (Mandatory), User must provide AMI ID. This is in String format

instance_type - (Optional), default is t3.micro

security_group_ids - (Mandatory), User must provide list of SG ID

## Outputs
public_ip - Public IP of the instance created

private_ip - Private IP of the instance created

instance_id - Instance ID of the instance created
