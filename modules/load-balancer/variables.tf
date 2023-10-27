variable "workspace" {
    type = string
    default = "default"
}
variable "azs" {
    type = list(string)
}
variable "vpc_id" {
    type=string
}
variable "public_subnets_ids" {
    type = list(string)
}