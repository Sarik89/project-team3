module "wordpress" {
  depends_on = [
    kubernetes_config_map.example
  ]
  source               = "./terraform-helm-local"
  deployment_name      = "${var.app_name}-${var.environment}"
  deployment_namespace = module.team-namespace.namespace
  deployment_path      =  "charts/application"
  
  values_yaml          = <<EOF
replicaCount: 1
image:
  repository: "${var.repository}"
  tag: "${var.app_version}"
imagePullSecrets: 
  - name: artifact-registry
service:
  type: ClusterIP
  port: "${var.app_port}"  
ingress:
 enabled: true
 className: "nginx"
 annotations:
   cert-manager.io/cluster-issuer: letsencrypt-prod
   nginx.ingress.kubernetes.io/proxy-body-size: "0"
   ingress.kubernetes.io/ssl-redirect: "false"
   acme.cert-manager.io/http01-edit-in-place: "true"
 hosts:
   - host: application.nanokredit.net
     paths:
       - path: /
         pathType: ImplementationSpecific
 tls:
 - secretName: chart-example-tls
   hosts:
     - application.nanokredit.net
EOF

}


