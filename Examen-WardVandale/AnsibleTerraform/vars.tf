variable "password" {
  type = string
  sensitive = true

}

variable "user" {
  type = string
  sensitive = true
}

variable "student" {
  default = "ward"
}

variable "folder_path" {
  default = "ward-vandale"
}

variable "vm_hostname" {
  default = "webserver"
}

variable "vm_pwd" {
  type = string
  sensitive = true
}