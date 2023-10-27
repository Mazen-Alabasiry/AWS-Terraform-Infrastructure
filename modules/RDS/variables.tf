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
variable "rds_sg_ids" {
  description = "input in array "
  type = list(string)
  default = []
}