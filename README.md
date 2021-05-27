# terraform-digitalocean-droplet

For creating a droplet(ubuntu or centos) in the Digital ocean using terraform script.

 You can run the run.sh script, which will launch ubuntu 18/centos 7 droplet:
 
      run.sh <droplet_name> <droplet_name.pub> centos s-1vcpu-1gb blr1
  
 If you want to launch ubuntu droplet in new york:
 
      run.sh <droplet_name> <droplet_name.pub> ubuntu s-1vcpu-1gb nyc1
   
  ##Above script will create a droplet and store the private key and public key of the server in /tmp/server/<SERVER_NAME> folder##
   
   
 For getting the list of the type of droplet you may check the below link where there is a column slug from which you can select your type of droplet:
 
     https://developers.digitalocean.com/documentation/changelog/api-v2/new-size-slugs-for-droplet-plan-changes/

 And for selecting region :
 
     https://docs.digitalocean.com/products/platform/availability-matrix/#:~:text=DigitalOcean's%20datacenters%20are%20in%20the,SFO3%3A%20San%20Francisco%2C%20United%20States

Create a personal access token key on your DigitalOcean account, then export the key to the machine where the script will be executed:
   
     export DO_TOKEN=<VALUE>

 
