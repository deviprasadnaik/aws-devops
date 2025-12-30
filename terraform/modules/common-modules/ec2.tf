resource "aws_instance" "this" {
  for_each = var.enable_ec2 ? { create = true } : {}

  ami                    = data.aws_ami.this.id
  instance_type          = "t2.micro"
  iam_instance_profile   = aws_iam_instance_profile.this["create"].name
  subnet_id              = var.ec2_subnet_id
  vpc_security_group_ids = [aws_security_group.this["create"].id]

  user_data = templatefile("${path.module}/files/userdata.sh", {})

  tags = {
    Name = "DevOps"
  }
}

resource "aws_iam_instance_profile" "this" {
  for_each = var.enable_ec2 ? { create = true } : {}

  name = "DevOps-Instance"
  role = aws_iam_role.this["create"].name
}

resource "aws_security_group" "this" {
  for_each = var.enable_ec2 ? { create = true } : {}

  name   = "ec2-sg"
  vpc_id = var.vpc_id

  #   ingress {
  #     from_port   = 8080
  #     to_port     = 8080
  #     protocol    = "tcp"
  #     cidr_blocks = ["0.0.0.0/0"]
  #   }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
