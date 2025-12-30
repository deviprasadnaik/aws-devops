resource "aws_instance" "this" {
  ami                    = data.aws_ami.this.id
  instance_type          = "t2.micro"
  iam_instance_profile   = aws_iam_instance_profile.this.name
  subnet_id              = data.aws_subnets.this.ids[0]
  vpc_security_group_ids = [aws_security_group.this.id]

  user_data = templatefile("${path.module}/files/userdata.sh", {})

  tags = {
    Name = "codedeploy-ec2"
  }
}

resource "aws_iam_instance_profile" "this" {
  name = "ec2-codedeploy-profile"
  role = aws_iam_role.ec2CodedeployRole.name
}
