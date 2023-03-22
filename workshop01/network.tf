resource "docker_network" "network_ws1" {
  name = "network_${var.namespace}"
}
