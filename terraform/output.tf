output "app_url" {
  description = "URL FastAPI додатку"
  value       = "http://${aws_instance.app_server.public_ip}:80"
}
