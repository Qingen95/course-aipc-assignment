resource "local_file" "nginx_conf" {
    filename = "nginx.conf"
    content = templatefile("nginx.conf.tftpl", {
        domain_host = var.domain_host,
        ports = docker_container.backend_ws1[*].ports[0].external
    })
}