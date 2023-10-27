variable "subnets" {
  type = list(string) 
  description = "private subnets"
}
variable "workspace" {
  type = string
  default = "default"
}
variable "azs" {
  type = list(string)
}
variable "ami" {
  type = string
  default = ""
}
variable "instance_type" {
  type = string
  default = "t2.micro"
}
variable "user_data" {
  type = string
  default = ""
}
variable "key_name" {
  type = string
  default = "" 
}
variable "ec2_sg_ids" {
  type = list(string)
  description = "input in array "
  default = []
}