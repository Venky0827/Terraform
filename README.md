A custom ami, VPC, 1 public & 2 private subnets, 1 public & 1 private routing table, internet gateway, route table association, ec2 instance will be created using these files

CMDS to run in Jenkins

#!/bin/bash
ls -al
pwd
echo "Running the packer script now..!!"
echo .
echo .
packer build packer.json
echo .
echo .
terraform init
terraform apply --var-file test.tfvars -var 'aws_access_key=AKIAWPGZFNAFKATV32P5' -var 'aws_secret_key=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' --auto-approve
echo "Infra Built Sucessfully....!!!"
