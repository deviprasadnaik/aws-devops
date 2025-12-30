resource "aws_route53_zone" "this" {
  name = "example.internal"

  vpc {
    vpc_id = aws_vpc.this.id
  }

  comment = "Private zone for RDS abstraction"
}

resource "aws_route53_record" "this" {
  zone_id = aws_route53_zone.this.zone_id
  name    = "db.prod"
  type    = "CNAME"
  ttl     = 30
  records = [aws_db_instance.this.address]
}


