variable  "allocated_storage" {
    default = 10
}
variable  "db_name" {
    type = string
    default = "database23"
}
variable  "engine" {
    default = "mysql"
}
variable  "engine_version" {
    type = string
}
variable  "instance_class" {
    default = "db.t3.micro"
}
variable  "username" {
    type = string
    default = "database23"
}
variable  "rdsdbpass" {
    default = "random_string.rds_db_password.result"
}

variable  "parameter_group_name" {
    default = "default.mysql5.7"
}
variable  "skip_final_snapshot" {
    default = true
}

variable "vpc_security_group_ids" {

}
variable "db_subnet_group_name" {

}
