variable "name" {
    default = "demo1"
}
variable "asg_max" {
    default = 3
}
variable "asg_min" {
    default = 1
}
variable "health_check_type" {
    default = "ELB"
}
variable "desired_capacity" {
    default = 1
}
variable "force_delete" {
    default = "true"
}
variable "instance_types" {
    default = "t2.micro"
}
variable "asg_sg" { 
}

variable "vpc_zone_id" {
    default = []
}
variable "health_check_grace_period" { 
    default = 300
}
variable "image_id" {
    default = "ami-0fe77b349d804e9e6"
}