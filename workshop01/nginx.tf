# to generate nginx configuration file
resource "local_file" "nginx_conf" {
  filename = "nginx.conf"
  content = templatefile("nginx.conf.tftpl", {
    domain_host = var.domain_host,
    ports       = docker_container.backend_ws1[*].ports[0].external
  })
}

resource "digitalocean_ssh_key" "aipc_nginx_pub" {
  name       = "nginx pub key"
  public_key = var.pub_key
}

resource "digitalocean_droplet" "server_nginx" {
  image  = "ubuntu-20-04-x64"
  name   = "nginx"
  region = "sgp1"
  size   = "s-1vcpu-1gb"

  connection {
    type        = "ssh"
    host        = self.ipv4_address
    user        = "root"
    private_key = file("~/.ssh/aipc_nginx")
    timeout     = "1m"
  }

  provisioner "remote-exec" {
    inline = [
      "apt update -y",
      "apt upgrade -y",
      "apt install nginx -y",
    ]
  }

  provisioner "file" {
    source      = local_file.nginx_conf.filename
    destination = "/etc/nginx/nginx.conf"
  }

  provisioner "remote-exec" {
    inline = [
      "systemctl restart nginx",
      "systemctl enable nginx",
    ]
  }

  ssh_keys = [digitalocean_ssh_key.aipc_nginx_pub.fingerprint]
}

output "server_nginx_ip" {
  value = digitalocean_droplet.server_nginx.ipv4_address
}