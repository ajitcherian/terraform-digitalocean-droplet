resource "digitalocean_droplet" "server" {
  image = "centos-7-x64"
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
      # install apache and docker
      "sudo yum update-y",
      "sudo yum install httpd -y",
      "sudo firewall-cmd --permanent --add-service=http",
      "sudo firewall-cmd --permanent --add-service=https",
      "sudo firewall-cmd --reload",
      "sudo systemctl start httpd",
      "sudo systemctl enable httpd",
      "sudo yum install -y yum-utils device-mapper-persistent-data lvm2",
      "sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo",
      "sudo yum install docker -y",
      "sudo systemctl start docker",
      "sudo systemctl enable docker"
    ]
  }
}
