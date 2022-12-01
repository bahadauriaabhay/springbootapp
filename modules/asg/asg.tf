resource "aws_autoscaling_group" "asg" {
  name                      = var.name
  max_size                  = var.asg_max
  min_size                  = var.asg_min
  health_check_grace_period = var.health_check_grace_period
  health_check_type         = var.health_check_type
  desired_capacity          = var.desired_capacity
  force_delete              = var.force_delete
  launch_configuration      = aws_launch_configuration.as_conf.name
  vpc_zone_identifier       = var.vpc_zone_id
}

resource "aws_launch_configuration" "as_conf" {
  name_prefix   = "${var.name}-"
  image_id      = var.image_id
  instance_type = "${var.instance_types}"
  security_groups = var.asg_sg
#  associate_public_ip_address = true
  user_data = <<EOF
#!/bin/bash
echo ECS_CLUSTER=${var.name} >> /etc/ecs/ecs.config;echo ECS_BACKEND_HOST= >> /etc/ecs/ecs.config;
cd /tmp
sudo yum install -y https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/linux_amd64/amazon-ssm-agent.rpm
sudo systemctl enable amazon-ssm-agent
sudo systemctl start amazon-ssm-agent
EOF
  iam_instance_profile = aws_iam_instance_profile.ecs-instance-profile.name
  lifecycle {
    create_before_destroy = true
  }
}
output "asg_arn" {
  value = aws_autoscaling_group.asg.arn
}
