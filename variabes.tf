
#Note: variables values are placed in variables.tfvars file for more secuirty

variable "workspace" {
  type = string
  default = "default"
}
variable "vpc_cidr" {
  type = string
}

variable "public_subnet_cidrs" {
  type        = list(string)
  description = "Public Subnet CIDR values"
}

variable "private_subnet_cidrs" {
  type        = list(string)
  description = "Private Subnet CIDR values"
}

variable "azs" {
  type        = list(string)
  description = "Availability Zones"
}
variable "ami" {
  type        = string
  description = "ami for ec2 and launch template"
}

variable "instance_type" {
  type = string
}

variable "key_name" {
  type = string
}