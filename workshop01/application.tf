resource "docker_image" "backend_ws1_v3" {
  name = "chukmunnlee/bgg-backend:v3"
}

resource "docker_container" "backend_ws1" {
  count = var.backend_instance_count
  name  = "backend_ws1_${count.index}"
  image = docker_image.backend_ws1_v3.image_id
  ports {
    internal = 3000
    external = 8080 + count.index
  }
  env = ["BGG_DB_USER=root","BGG_DB_PASSWORD=changeit","BGG_DB_HOST=${docker_container.database_mysql_ws1.name}"]
  networks_advanced {
    name = docker_network.network_ws1.name
  }
}