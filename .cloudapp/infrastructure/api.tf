# 声明应用包所暴露的应用接口，以及其对应的接口网关和接口后端


resource "cloudapp_tke_service" "backend" {
  resource_manager = "helm"
  chart_config = {
    cluster_id   = tencentcloud_kubernetes_cluster.tke-cluster.id
    chart_id     = cloudapp_helm_app.app.id
    service_name = "${var.app_name}-api-service"
  }
}

resource "cloudapp_api_handler" "APIServer" {
  vpc_id           = var.app_target.vpc.id
  host             = cloudapp_tke_service.backend.host
  handler_protocol = "http"
  handler_path     = "/api/:api_name"
}

resource "cloudapp_api" "GetTodoList" {
  handler_id = cloudapp_api_handler.APIServer.id
  api_name   = "GetTodoList"
  api_desc   = "获取代办列表"
}

resource "cloudapp_api" "AddTodo" {
  handler_id = cloudapp_api_handler.APIServer.id
  api_name   = "AddTodo"
  api_desc   = "新增待办项"
}

resource "cloudapp_api" "RemoveTodo" {
  handler_id = cloudapp_api_handler.APIServer.id
  api_name   = "RemoveTodo"
  api_desc   = "移除待办项"
}
