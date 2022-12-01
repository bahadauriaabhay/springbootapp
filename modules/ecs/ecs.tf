resource "aws_ecs_cluster" "ecs_cluster" {
  name = var.name
}

resource "aws_ecs_cluster_capacity_providers" "ecs_capacity_providers" {
  cluster_name = aws_ecs_cluster.ecs_cluster.name
  capacity_providers = [aws_ecs_capacity_provider.ecs_capacity_provider.name]

  #default_capacity_provider_strategy {
  #  base              = 1
  #  weight            = 100
  #  capacity_provider = aws_ecs_capacity_provider.ecs_capacity_provider.name
  #}
}

resource "aws_ecs_capacity_provider" "ecs_capacity_provider" {
  name = "provider-${var.name}"

  auto_scaling_group_provider {
    auto_scaling_group_arn = var.asg_arn
  }
}
