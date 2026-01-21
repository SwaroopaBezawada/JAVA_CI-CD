output "ecr_repository_url" {
  value = aws_ecr_repository.app.repository_url
}

output "alb_url" {
  value = "http://${aws_lb.this.dns_name}"
}
