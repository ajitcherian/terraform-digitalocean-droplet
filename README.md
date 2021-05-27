# terraform-digitalocean-droplet

For creating a droplet(ubuntu or centos) in digital ocean using terraform script.

 You can run the run.sh script, which will launch ubuntu 18/centos 7 droplet:
 
   $run.sh droplet_name droplet_name.pub centos s-1vcpu-1gb blr1
 
 If you want to launch ubuntu droplet in new york:
 
   $run.sh droplet_name droplet_name.pub ubuntu s-1vcpu-1gb nyc1
   
 For getting list of type of droplet you may check below link:
 
     https://developers.digitalocean.com/documentation/changelog/api-v2/new-size-slugs-for-droplet-plan-changes/

 And for region code: 
 
     https://docs.digitalocean.com/products/platform/availability-matrix/#:~:text=DigitalOcean's%20datacenters%20are%20in%20the,SFO3%3A%20San%20Francisco%2C%20United%20States


Export digital oceaan key in machine where the scrippt will be executed:
  export DO_TOKEN=<VALUE>

  
