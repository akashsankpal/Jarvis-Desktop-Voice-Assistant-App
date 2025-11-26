resource "aws_security_group" "jarvis_sg" {
  name = "jarvis-sg"
  description = "security group for jarvis"

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

   ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "App Port"
    from_port   = 5000
    to_port     = 5000
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

resource "aws_instance" "jarvis" {
  ami = var.my_ami
  instance_type = var.my_instance
  key_name = var.my_key
  vpc_security_group_ids = [aws_security_group.jarvis_sg.id]
  tags = {
    Name= "jarvis_server"
  }
}
