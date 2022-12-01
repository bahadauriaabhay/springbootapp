output "endpoint" {
    value = aws_db_instance.this.endpoint
}
output "name" {
    value = aws_db_instance.this.name
}
output "username" {
    value = aws_db_instance.this.username
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