resource "digitalocean_ssh_key" "ws2_pub_key" {
  name       = "${var.namespace} pub key"
  public_key = file("${var.private_key_path}.pub")
}

resource "digitalocean_droplet" "server_workshop02" {
  image  = "ubuntu-20-04-x64"
  name   = "server-${var.namespace}"
  region = "sgp1"
  size   = "s-1vcpu-2gb"
  ssh_keys = [digitalocean_ssh_key.ws2_pub_key.fingerprint]
}

# to generate ansible server inventory file
resource "local_file" "server_inventory" {
  filename = "inventory.yaml"
  content = templatefile("server_inventory.yaml.tftpl", {
    server_host = digitalocean_droplet.server_workshop02.ipv4_address,
    private_key_path = var.private_key_path
  })
}
