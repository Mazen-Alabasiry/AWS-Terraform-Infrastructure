resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "my-db-subnet-group"
  subnet_ids = [for subnet in var.subnets : subnet]

}

# Create RDS instances (Primary and Standby) in different availability zones.
resource "aws_db_instance" "primary_rds" {
  identifier             = "primary-rds-${var.workspace}"
  allocated_storage      = 20
  storage_type           = "gp2"
  engine                 = "mysql"
  engine_version         = "5.7"
  instance_class         = "db.t2.micro"
  db_name                = "mydb"
  username               = "admin"
  password               = "password"
  skip_final_snapshot    = true
  multi_az               = false
  availability_zone      = element(var.azs, 0)
  vpc_security_group_ids = var.rds_sg_ids
  db_subnet_group_name   = aws_db_subnet_group.db_subnet_group.name
}

resource "aws_db_instance" "standby_rds" {
  identifier             = "standby-rds-${var.workspace}"
  count                  = length(var.azs) > 1 ? 1 : 0
  allocated_storage      = 20
  storage_type           = "gp2"
  engine                 = "mysql"
  engine_version         = "5.7"
  instance_class         = "db.t2.micro"
  db_name                = "mydb"
  username               = "admin"
  password               = "password"
  multi_az               = false
  skip_final_snapshot    = true
  availability_zone      = element(var.azs, 1)
  vpc_security_group_ids = var.rds_sg_ids
  db_subnet_group_name   = aws_db_subnet_group.db_subnet_group.name
}


