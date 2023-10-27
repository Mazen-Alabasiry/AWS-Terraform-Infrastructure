variable "workspace" {
  type = string
  default = "default"
}
variable "vpc_cidr" {
  type = string
  default = "10.0.0.0/16"
}
variable "name" {
  type = string
  default = "My"
}
variable "public_subnet_cidrs" {
  type = list(string)
  default = ["10.1.0.0/16"]
}
variable "private_subnet_cidrs" {
  type = list(string)
  default = []
}
variable "azs" {
  type = list(string)
}