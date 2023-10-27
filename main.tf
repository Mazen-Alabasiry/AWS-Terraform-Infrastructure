
module "network" {
  source               = "./modules/network"
  workspace            = var.workspace
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  azs                  = var.azs
  name                 = "Abasiiry"
}
module "ec2" {
  source        = "./modules/ec2"
  workspace     = var.workspace
  azs           = var.azs
  ami           = var.ami
  subnets       = module.network.private_subnets_ids
  ec2_sg_ids    = [aws_security_group.ec2_sg.id]
  instance_type = var.instance_type
  key_name      = var.key_name
  user_data     = filebase64("./user-data-script.sh")
  depends_on    = [aws_security_group.ec2_sg]
}
module "rds" {
  source     = "./modules/RDS"
  workspace  = var.workspace
  azs        = var.azs
  subnets    = module.network.private_subnets_ids
  rds_sg_ids = [aws_security_group.rds_sg.id]
  depends_on = [aws_security_group.rds_sg]
}
module "LoadBalncer" {
  source             = "./modules/load-balancer"
  workspace          = var.workspace
  azs                = var.azs
  vpc_id             = module.network.vpc_id
  public_subnets_ids = module.network.public_subnets_ids
}
module "auto-scaling-group" {
  source            = "./modules/auto-scaling-group"
  workspace         = var.workspace
  azs               = var.azs
  ami               = var.ami
  subnets           = module.network.private_subnets_ids
  ec2_sg_ids        = [aws_security_group.ec2_sg.id]
  instance_type     = var.instance_type
  key_name          = var.key_name
  user_data         = filebase64("./user-data-script.sh")
  min_size          = 2
  max_size          = 2
  desired_capacity  = 2
  target_group_arns = module.LoadBalncer.target_groups_arns
}