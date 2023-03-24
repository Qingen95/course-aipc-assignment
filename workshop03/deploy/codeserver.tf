# get existing docker image built from packer
data "digitalocean_image" "codeserver_image" {
  name = "codeserver_image"
}

# get existing public key
data "digitalocean_ssh_key" "aipc_pub_key" {
  name = "workshop03 pub key"
}

# spin up droplet using image
resource "digitalocean_droplet" "golden_codeserver" {
  image    = data.digitalocean_image.codeserver_image.image
  name     = "golden-codeserver"
  region   = "sgp1"
  size     = "s-1vcpu-1gb"
  ssh_keys = [data.digitalocean_ssh_key.aipc_pub_key.fingerprint]

  connection {
    type        = "ssh"
    host        = self.ipv4_address
    user        = "root"
    private_key = file(var.private_key_path)
    timeout     = "1m"
  }

  # replace variables of config files set up during build
  provisioner "remote-exec" {
    inline = [
      "sed -i 's/<codeserver_domain>/${self.ipv4_address}/g' /etc/nginx/sites-available/code-server.conf",
      "sed -i 's/<codeserver_password>/${var.codeserver_password}/g' /lib/systemd/system/code-server.service",

      "systemctl daemon-reload",
      "systemctl restart nginx",
      "systemctl restart code-server"
    ]
  }
}

output "golden_codeserver_ip" {
  value = digitalocean_droplet.golden_codeserver.ipv4_address
}