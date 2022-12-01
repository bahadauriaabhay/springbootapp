resource "aws_iam_role" "ecsTaskExecutionRole" {
  name               = "execution-task-role"
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
}

data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy_attachment" "ecsTaskExecutionRole_policy" {
  role       = aws_iam_role.ecsTaskExecutionRole.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}
resource "aws_iam_role_policy_attachment" "aws-ssm-parameter" {
  role       = aws_iam_role.ecsTaskExecutionRole.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMReadOnlyAccess"
}
####task_definition
resource "aws_ecs_task_definition" "task" {
  family = "task"
  container_definitions = jsonencode([
    {
      name      = "app-${var.name}"
      image     = "${var.imageURI}"
      cpu       = "${var.container_cpu}"
      memory    = "${var.container_memory}"
      essential = true
      portMappings = [
        {
          containerPort = var.containerPort
          hostPort      = var.hostPort
        }
      ]
      secrets     = [for k, v in var.ssm_variables : { name : k, valueFrom : v }]
    },
    ])
  execution_role_arn       = aws_iam_role.ecsTaskExecutionRole.arn
  task_role_arn            = aws_iam_role.ecsTaskExecutionRole.arn
}