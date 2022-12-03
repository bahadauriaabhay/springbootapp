output "endpoint" {
    value = aws_db_instance.this.endpoint
}
output "name" {
    value = aws_db_instance.this.name
}

output "rdsdbpass" {
    value = random_string.rds_db_password.result
}

output "username" {
    value = aws_db_instance.this.username
}
output "db_name" {
    value = aws_db_instance.this.db_name
}
output "ssm_parameter_rds_endpoint" {
    value = aws_ssm_parameter.rds_endpoint.id
}
output "ssm_parameter_rds_dbname" {
    value = aws_ssm_parameter.rds_dbname.id
}
output "ssm_parameter_rds_user" {
    value = aws_ssm_parameter.rds_user.id
}
output "ssm_parameter_rds_password" {
    value = aws_ssm_parameter.rds_password.id
}