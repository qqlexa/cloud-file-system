variable "aws_region" {
  default = "us-east-1"
}

variable "ami_id" {
  default = "ami-0c02fb55956c7d316" # Amazon Linux 2 AMI (змінити залежно від регіону)
}

variable "instance_type" {
  default = "t2.micro"
}

variable "repo_url" {
  description = "URL репозиторію з FastAPI кодом"
}
