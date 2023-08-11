# 这里定义用到的密码

resource "random_password" "db" {
  length           = 16
  override_special = "_+-&=!@#$%^*()"
}