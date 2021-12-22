variable "username" {
  type        = string
  sensitive   = true
}

variable "password" {
  type        = string
  sensitive   = true
}

variable "folder_path" {
  default = "IHaveNoBrainCells"
}

variable "vault_pass" {
  type        = string
  sensitive   = true
}