variable "health_check_type" {
  default = "ELB"
}
variable "imageURI" {
  default = "nginx"
}
variable "desired_capacity" {
  default = "1"
}
variable "force_delete" {
  default = "true"
}

variable "name" {
  description = "Name of this ECS cluster."
  default = "demo1"
}
variable "container_cpu" {
  default = "100"
}
variable "container_memory" {
  default = "512"
}
variable "containerPort" {
  default = 80
}
variable "hostPort" {
  default = 80
}
variable "instance_types" {
  description = "Instance type for ECS workers"
  default     = []
}
variable "app_port" {
  description = "port expose on image"
  default     = "80"
}


variable "architecture" {
  default     = "x86_64"
  description = "Architecture to select the AMI, x86_64 or arm64"
}

variable "volume_type" {
  default     = "gp2"
  description = "The EBS volume type"
}

variable "on_demand_percentage" {
  description = "Percentage of on-demand intances vs spot."
  default     = 100
}

variable "on_demand_base_capacity" {
  description = "You can designate a base portion of your total capacity as On-Demand. As the group scales, per your settings, the base portion is provisioned first, while additional On-Demand capacity is percentage-based."
  default     = 0
}

variable "vpc_id" {
  description = "VPC ID to deploy the ECS cluster."
}
variable "public_sg" {
  
}
#variable "private_subnet_ids" {
#  type        = list(string)
#  default = [module.network.private_subnet_ids1,module.network.private_subnet_ids2]
#  description = "List of private subnet IDs for ECS instances and Internal ALB when enabled."
#}
#
#variable "public_subnet_ids" {
#  type        = list(string)
#  default = [module.network.public_subnet_ids1,module.network.public_subnet_ids2]
#  description = "List of public subnet IDs for ECS ALB."
#}

variable "security_group_ids" {
  type        = list(string)
  default     = []
  description = "Extra security groups for instances."
}

variable "security_group_ecs_nodes_outbound_cidrs" {
  type        = list(string)
  default     = ["0.0.0.0/0"]
  description = "ECS Nodes outbound allowed CIDRs for the security group."
}

variable "userdata" {
  default     = ""
  description = "Extra commands to pass to userdata."
}

variable "alb" {
  default     = true
  description = "Whether to deploy an ALB or not with the cluster."
}

variable "asg_min" {
  default     = 1
  description = "Min number of instances for autoscaling group."
}

variable "asg_max" {
  default     = 1
  description = "Max number of instances for autoscaling group."
}

variable "asg_target_capacity" {
  default     = 90
  description = "Target average capacity percentage for the ECS capacity provider to track for autoscaling."
}

variable "autoscaling_health_check_grace_period" {
  default     = 300
  description = "The length of time that Auto Scaling waits before checking an instance's health status. The grace period begins when an instance comes into service."
}

variable "autoscaling_default_cooldown" {
  default     = 300
  description = "The amount of time, in seconds, after a scaling activity completes before another scaling activity can start."
}

variable "instance_volume_size" {
  description = "Volume size for docker volume (in GB)."
  default     = 30
}

variable "instance_volume_size_root" {
  description = "Volume size for root volume (in GB)."
  default     = 16
}

variable "alarm_prefix" {
  type        = string
  description = "String prefix for cloudwatch alarms. (Optional)"
  default     = "alarm"
}

variable "vpn_cidr" {
  default     = ["10.37.0.0/16"]
  description = "Cidr of VPN to grant ssh access to ECS nodes"
}

variable "asg_arn" {

}
variable "public_sub" {

}
variable "desired_count" {
  default = 1
}

variable "ssm_variables" {
  default = {}
}
####target group
variable "path" {
  default = "/"
}
#variable "port" {
#  default = 80
#}
variable "healthy_threshold" {
  default = 6
}
variable "unhealthy_threshold" {
  default = 2
}
variable "timeout" {
  default = 2
}
variable "interval" {
  default = 5
}
variable "matcher" {
  default = 200
}

variable "autoscaling_cpu" {
  default     = false
  description = "Enables autoscaling based on average CPU tracking"
}

variable "autoscaling_memory" {
  default     = false
  description = "Enables autoscaling based on average Memory tracking"
}

variable "autoscaling_max" {
  default     = 4
  description = "Max number of containers to scale with autoscaling"
}

variable "autoscaling_min" {
  default     = 1
  description = "Min number of containers to scale with autoscaling"
}

variable "autoscaling_target_cpu" {
  default     = 50
  description = "Target average CPU percentage to track for autoscaling"
}

variable "autoscaling_target_memory" {
  default     = 90
  description = "Target average Memory percentage to track for autoscaling"
}

variable "autoscaling_scale_in_cooldown" {
  default     = 300
  description = "Cooldown in seconds to wait between scale in events"
}

variable "autoscaling_scale_out_cooldown" {
  default     = 300
  description = "Cooldown in seconds to wait between scale out events"
}
