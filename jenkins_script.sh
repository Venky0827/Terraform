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
