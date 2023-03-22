resource "docker_volume" "volume_database_ws1" {
  name = "volume_database_${var.namespace}"
}

resource "docker_image" "image_mysql" {
  name = "chukmunnlee/bgg-database:v3.1"
}

resource "docker_container" "database_mysql_ws1" {
  name  = "database_${var.namespace}"
  image = docker_image.image_mysql.image_id
  ports {
    internal = 3306
    external = 3306
  }
  volumes {
    volume_name    = docker_volume.volume_database_ws1.name
    container_path = "/var/lib/mysql"
  }
  networks_advanced {
    name = docker_network.network_ws1.name
  }
}