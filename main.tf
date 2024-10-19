#provider block
provider "aws" {
    region     = "us-east-1"
    access_key = "AWS_ACCESS_KEY"
    secret_key = "AWS_SECRET_KEY"
}

#resource block
resource "aws_instance" "first_instance" {
    ami               = "ami-0866a3c8686eaeeba"
    instance_type     = "t3.large"
    key_name          = "My-key"
    vpc_security_group_ids = [ aws_security_group.first_security_group.id ]
    user_data         = file("${path.module}/user-data.sh")

    tags = {
      Name = "Instance_from_Terraform"
    }
}


#security-group block
resource "aws_security_group" "first_security_group" {
  name        = "first_security_group"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 5050
    to_port     = 5050
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 5173
    to_port     = 5173
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

#output block
output "instance_id" {
  value = aws_instance.first_instance.public_ip
}
