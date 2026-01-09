data "aws_security_group" "this" {
  name   = "default"
  vpc_id = module.common-modules.defaultVpc
}

data "aws_subnets" "public" {
  filter {
    name   = "vpc-id"
    values = [module.common-modules.defaultVpc]
  }

  filter {
    name   = "map-public-ip-on-launch"
    values = ["true"]
  }
}
