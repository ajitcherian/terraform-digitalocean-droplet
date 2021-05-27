resource "digitalocean_droplet" "server" {
  image = "ubuntu-18-04-x64"
  name = "server"
  region = "nyc1"
  size = "s-1vcpu-1gb"
  private_networking = true
  ssh_keys = [
    var.ssh_fingerprint
  ]
  connection {
    host = self.ipv4_address
    user = "root"
    type = "ssh"
    private_key = file(var.pvt_key)
    timeout = "2m"
  }


provisioner "remote-exec" {
    inline = [
      # install apache
      "sudo apt-get update",
      "sudo apt install apache2 -y",
      "sudo ufw allow 'Apache Full'",
      "sudo start apache2",
      "sudo a2enmod proxy",
      "sudo a2enmod proxy_http",
      "sudo a2enmod proxy_balancer",
      "sudo a2enmod lbmethod_byrequests",
      "sudo systemctl restart apache2"
    ]
  }
}
