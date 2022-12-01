output "alb_dns_name" {
  value = aws_lb.test.dns_name
}

output "task_definition" {
  value = aws_ecs_task_definition.task.arn
}














#output "alb_dns_name" {
#  value = aws_lb.ecs.*.dns_name
#}
#
#output "ecs_arn" {
#  value = aws_ecs_cluster.ecs.arn
#}
#
#output "ecs_name" {
#  value = aws_ecs_cluster.ecs.name
#}
#
#output "ecs_nodes_secgrp_id" {
#  value = aws_security_group.ecs_nodes.id
#}
#