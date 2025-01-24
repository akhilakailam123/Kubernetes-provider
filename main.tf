resource "kubernetes_namespace" "test" {
  metadata {
    name = "terraform-namespace"
  }
}

resource "kubernetes_deployment" "test" {
  metadata {
    name      = "terraform-deployment"
    namespace = kubernetes_namespace.test.metadata.0.name
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        app = var.deployment_label
      }
    }
    template {
      metadata {
        labels = {
          app = var.deployment_label
        }
      }
      spec {
        container {
          image = "nginx"
          name  = "nginx-container"
          port {
            container_port = 80
          }
        }
      }
    }
  }
}
resource "kubernetes_service" "test" {
  metadata {
    name      = "terraform-service"
    namespace = kubernetes_namespace.test.metadata.0.name
  }
  spec {
    selector = {
      app = kubernetes_deployment.test.spec.0.template.0.metadata.0.labels.app
    }
    type = "LoadBalancer"
    port {
      port        = 80
      target_port = 80
    }
  }
}