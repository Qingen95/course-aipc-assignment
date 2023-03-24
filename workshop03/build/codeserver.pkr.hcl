source "digitalocean" "codeserver_image" {
  api_token     = var.do_token
  image         = "ubuntu-20-04-x64"
  region        = "sgp1"
  size          = "s-1vcpu-1gb"
  ssh_username  = "root"
  snapshot_name = "codeserver_image"
}

build {
  sources = [
    "source.digitalocean.codeserver_image",
  ]

  provisioner ansible {
    playbook_file = "./ansible/playbooks/main.yaml"
    ansible_ssh_extra_args = [
      "-oHostKeyAlgorithms=+ssh-rsa -oPubkeyAcceptedKeyTypes=+ssh-rsa"
    ]
  }
}