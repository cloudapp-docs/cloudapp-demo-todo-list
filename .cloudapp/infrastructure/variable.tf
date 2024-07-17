# 云应用系统变量，主要是镜像仓库相关变量
variable "cloudapp_cam_role" {}
variable "cloudapp_repo_server" {}
variable "cloudapp_repo_username" {}
variable "cloudapp_repo_password" {}

variable "app_name" {
  type    = string
  default = "cloudapp-demo-todo-list"
}

# 用户选择的地域
variable "app_zone" {
  type = object({
    region    = string
    zone = string
  })
}

# 用户选择的安装目标位置，VPC 和子网，在 package.yaml 中定义了输入组件
variable "app_target" {
  type = object({
    region    = string
    region_id = string
    vpc = object({
      id         = string
      cidr_block = string
    })
    subnet = object({
      id   = string
      zone = string
    })
  })
}

variable "app_sg" {
  type = object({
    region    = string
    region_id = string
    security_group = object({
      id         = string
    })
  })
}

variable "charge_perpaid_auto_renew" {
  type            = bool
  default         = false
}

variable "charge_type" {
  type            = string
  default = "POSTPAID"
}

variable "charge_perpaid_period" {
  type            = number
  default = 1
}

variable "app_cvm" {
  type = object({
    instance_type = string
  })
  default = {
    instance_type = "S6.MEDIUM4"
  }
}

variable "app_cvm_image" {
  type = object({
    image_id = string
  })

  default = {
    image_id = "img-mmytdhbn"
  }
}