output "alb_dns_name" {
  value = module.ecs.alb_dns_name
}
output "task-definition" {
  value = module.ecs.task_definition
}
output "rds_user_password" {
  value = module.rds.rdsdbpass
}
output "rds-username" {
  value = module.rds.username
}
output "rds-endpoint" {
  value = module.rds.endpoint
}
output "db_name" {
  value = module.rds.db_name
}