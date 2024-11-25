provider "aws" {
  region = var.aws_region
}

resource "aws_instance" "app_server" {
  ami           = var.ami_id
  instance_type = var.instance_type

  # Відкриваємо порт для HTTP-запитів
  security_groups = [aws_security_group.app_sg.name]

  # Скрипт для встановлення FastAPI і запуску
  user_data = <<-EOF
              #!/bin/bash
              sudo apt update -y
              sudo apt install -y python3 python3-pip
              pip3 install fastapi uvicorn
              cd /home/ubuntu
              git clone ${var.repo_url}
              cd cloud-file-system
              pip3 install -r requirements.txt
              nohup uvicorn app.main:app --host 0.0.0.0 --port 80 &
              EOF
}

resource "aws_security_group" "app_sg" {
  name        = "fastapi-sg"
  description = "Allow HTTP access"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output "app_public_ip" {
  value = aws_instance.app_server.public_ip
}
