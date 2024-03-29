resource "docker_image" "backend_ws1_v3" {
  name = "chukmunnlee/bgg-backend:v3"
}

resource "docker_container" "backend_ws1" {
  count = var.backend_instance_count
  name  = "backend_${var.namespace}_${count.index}"
  image = docker_image.backend_ws1_v3.image_id
  ports {
    internal = 3000
  }
  env = [
    "BGG_DB_USER=${var.database_user}",
    "BGG_DB_PASSWORD=${var.database_password}",
    "BGG_DB_HOST=${docker_container.database_mysql_ws1.name}"
  ]
  networks_advanced {
    name = docker_network.network_ws1.name
  }
}

output "backend_ports" {
  value = docker_container.backend_ws1[*].ports[0].external
}