resource "random_string" "rds_db_password" {
  length  = 34
  special = false
}

resource "aws_db_instance" "this" {
  allocated_storage      = var.allocated_storage
  db_name                = var.db_name
  engine                 = var.engine
  engine_version         = var.engine_version
  instance_class         = var.instance_class
  username               = var.username
  password               = random_string.rds_db_password.result
  parameter_group_name   = var.parameter_group_name
  skip_final_snapshot    = var.skip_final_snapshot
  vpc_security_group_ids = var.vpc_security_group_ids     
  db_subnet_group_name   = var.db_subnet_group_name

}
####aws_ssm_parameter_store
resource "aws_ssm_parameter" "rds_endpoint" {
  name  = "/${var.db_name}/ENDPOINT"
  type  = "String"
  value = aws_db_instance.this.endpoint
}
resource "aws_ssm_parameter" "rds_user" {
  name  = "/${var.db_name}/USER"
  type  = "String"
  value = var.username
}
resource "aws_ssm_parameter" "rds_dbname" {
  name  = "/${var.db_name}/NAME"
  type  = "String"
  value = var.db_name
}
resource "aws_ssm_parameter" "rds_password" {
  name  = "/${var.db_name}/PASS"
  type  = "SecureString"
  value = random_string.rds_db_password.result
}