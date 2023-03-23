variable "namespace" {
  default = "workshop01"
}

variable "do_token" {
  type      = string
  sensitive = true
}

variable "domain_host" {
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

variable "database_user" {
  type      = string
  sensitive = true
}

variable "database_password" {
  type      = string
  sensitive = true
}

variable "pub_key" {
  type      = string
  sensitive = true
}