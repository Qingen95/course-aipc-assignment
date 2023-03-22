variable "namespace" {
  default = "workshop01"
}

variable "do_token" {
  type      = string
  sensitive = true
}

variable "docker_host" {
  type      = string
  sensitive = true
}

variable "backend_instance_count" {
  type    = number
  default = 3
}