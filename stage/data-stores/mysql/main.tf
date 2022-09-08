provider "aws" {
  region = "us-east-2"

}

resource "aws_db_instance" "o1neinfra" {
    identifier_prefix = "oneinfra-off-and-running"
    engine = "mysql"
    allocated_storage = 5
    instance_class = "db.t2.micro"
    name = "o1neinfra_database"
    username = "admin"
    #password = "linkinpark"
    skip_final_snapshot = true

    # How should we set the password?
   #password = data.aws_secretsmanager_secret_version.db_password
    #secret_id = aws_secretsmanager_secret.db_password
    password = data.aws_secretsmanager_secret.db_password.secret_string

}

data "aws_secretsmanager_secret_version" "db_password" {
    secret_id = "data.aws_secretsmanager_secret_version.db_password.id"
}

