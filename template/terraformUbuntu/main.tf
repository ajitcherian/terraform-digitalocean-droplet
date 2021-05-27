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

resource "digitalocean_firewall" "server" {
  name = "server-SG"

  droplet_ids = [digitalocean_droplet.server.id]

  inbound_rule {
    protocol         = "tcp"
    port_range       = "22"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  inbound_rule {
    protocol         = "tcp"
    port_range       = "80"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  inbound_rule {
    protocol         = "tcp"
    port_range       = "443"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "tcp"
    port_range       = "1-65535"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "udp"
    port_range       = "1-65535"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

}

