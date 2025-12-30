# resource "aws_vpc" "this" {
#   cidr_block           = "10.0.0.0/16"
#   enable_dns_support   = true
#   enable_dns_hostnames = true

#   tags = {
#     Name = "rds-dr-vpc"
#   }
# }

# resource "aws_internet_gateway" "this" {
#   vpc_id = aws_vpc.this.id

#   tags = {
#     Name = "rds-dr-igw"
#   }
# }

# resource "aws_subnet" "public" {
#   vpc_id                  = aws_vpc.this.id
#   cidr_block              = "10.0.1.0/24"
#   availability_zone       = var.azs[0]
#   map_public_ip_on_launch = true

#   tags = {
#     Name = "public-subnet-1"
#   }
# }

# resource "aws_subnet" "private" {
#   for_each = var.private_subnets

#   vpc_id            = aws_vpc.this.id
#   cidr_block        = each.value.cidr
#   availability_zone = each.value.az

#   tags = {
#     Name = "private-${each.key}"
#   }
# }


# resource "aws_route_table" "public" {
#   vpc_id = aws_vpc.this.id

#   route {
#     cidr_block = "0.0.0.0/0"
#     gateway_id = aws_internet_gateway.this.id
#   }

#   tags = {
#     Name = "public-rt"
#   }
# }

# resource "aws_route_table_association" "this" {
#   subnet_id      = aws_subnet.public.id
#   route_table_id = aws_route_table.public.id
# }

# resource "aws_route_table" "private" {
#   vpc_id = aws_vpc.this.id

#   tags = {
#     Name = "private-rt"
#   }
# }

