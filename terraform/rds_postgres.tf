resource "aws_db_instance" "postgres" {
  identifier        = "cdc-postgres"
  engine            = "postgres"
  engine_version    = "14"
  instance_class    = "db.t3.micro"
  allocated_storage = 20

  username = "postgres"
  password = "postgres123"

  publicly_accessible = true
  skip_final_snapshot = true
}
