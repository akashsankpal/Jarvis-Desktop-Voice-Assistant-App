provider "aws" {
    region = "ap-south-1"
  
}

resource "aws_instance" "jarvis" {
  ami           = "ami-02b8269d5e85954ef"
  instance_type = "t2.micro"
  key_name      = aws_key_pair.jarvis_key.key_name
  vpc_security_group_ids = [aws_security_group.jarvis_sg.id]
    tags = {
    Name = "Jarvis-desktop"
  }
}