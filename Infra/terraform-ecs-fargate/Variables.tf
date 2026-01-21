variable "aws_region" {
  type    = string
  default = "eu-west-2"
}

variable "project_name" {
  type    = string
  default = "regapp"
}

variable "ecs_cluster_name" {
  type    = string
  default = "regapp-cluster"
}

variable "ecr_repo_name" {
  type    = string
  default = "regapp"
}

variable "image_tag" {
  type    = string
  default = "latest"
}
