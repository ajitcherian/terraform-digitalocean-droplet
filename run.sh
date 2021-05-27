#!/bin/bash
#change droplet name in variable server and droplet public in terraform plan
SERVER=$1
SERVER_PUBLIC_KEY=$2
OS=$3
sudo mkdir -p /tmp/server/$SERVER/terraform
sudo chmod 766 /tmp/server/$SERVER


# this will not stop the script and ask for password IT will create private key with name $SERVER
ssh-keygen -b 2048 -t rsa -f /tmp/server/$SERVER/$SERVER -q  -N ""

#add key to digital ocean
file=$(cat /tmp/server/$SERVER/$SERVER_PUBLIC_KEY)
sudo doctl compute ssh-key create $SERVER --public-key "$file"

#Get fingerprint id
sudo rm -rf text
sudo doctl compute ssh-key list | grep $SERVER | rev |  cut -c -47 | rev > /tmp/text

# Copy only the plan and variable files
sudo cp -r  /tmp/template/terraformUbuntu/*.tf /tmp/server/$SERVER/terraform/

if [[ $OS = "ubuntu" ]]
then
  sudo cp -r  ./template/terraformUbuntu/*.tf /tmp/server/$SERVER/terraform/
else
  sudo cp -r  ./template/terraformCentos/*.tf /tmp/server/$SERVER/terraform/
fi




# Renaming the resource
sudo sed -i 's/server/'$1'/g' /tmp/server/$SERVER/terraform/main.tf
sudo sed -i 's/s-1vcpu-1gb/'$4'/g' /tmp/server/$SERVER/terraform/main.tf
sudo sed -i 's/nyc1/'$5'/g' /tmp/server/$SERVER/terraform/main.tf
cd /tmp/server/$SERVER/terraform/

# Initialise the configuration
sudo terraform init -input=false

#DO_TOKEN = $DO_API_KEY

# Plan and deploy

SSH_FINGERPRINT=$(cat /tmp/text)
sudo terraform plan -input=false -var="do_token=${DO_TOKEN}" -var="pub_key=/tmp/server/$SERVER/$SERVER_PUBLIC_KEY" -var="pvt_key=/tmp/server/$SERVER/$SERVER" -var="ssh_fingerprint=${SSH_FINGERPRINT}" -out=droplet_create

sudo terraform apply droplet_create


cat /tmp/server/$SERVER/$SERVER
# Terraform will run the above script to benchmark the server
# Find your results in the Terraform output

# Once finished, destroy the server

#terraform plan -destroy -out=droplet_destroy
#terraform apply droplet_destroy
#sudo terraform destroy -input=false -var="do_token=${DO_TOKEN}" -var="pub_key=/tmp/server/test/test.pub" -var="pvt_key=/tmp/server/test/test" -var="ssh_fingerprint=${SSH_FINGERPRINT}"
# Cleaning up
#rm -rf /tmp/server/$SERVER/terraform/
