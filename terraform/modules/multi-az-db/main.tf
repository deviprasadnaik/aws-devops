module "common-modules" {
  source        = "../common-modules"
  ec2_subnet_id = aws_subnet.public.id
  enable_ec2    = true
  vpc_id        = aws_vpc.this.id
}