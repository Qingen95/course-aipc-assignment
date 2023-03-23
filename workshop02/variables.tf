variable "namespace" {
  default = "workshop02"
}

variable "do_token" {
  type      = string
  sensitive = true
}

variable "private_key_path" {
  type      = string
  sensitive = true
}