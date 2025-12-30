resource "aws_db_instance" "this" {
  identifier     = "prod-db"
  engine         = "mysql"
  engine_version = "8.0"
  instance_class = "db.t3.micro"

  allocated_storage = 20
  storage_type      = "gp3"

  db_name  = "prod_db"
  username = "admin"
  password = var.db_password

  vpc_security_group_ids = [aws_security_group.this.id]
  db_subnet_group_name   = aws_db_subnet_group.this.name

  backup_retention_period = 7
  backup_window           = "02:00-03:00"

  multi_az            = false
  publicly_accessible = false

  skip_final_snapshot = true
  deletion_protection = false

  tags = {
    Name = "prod-db"
  }
}
