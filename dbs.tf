resource "random_id" "db_name_suffix" {
  byte_length = 4
}


resource "google_sql_database_instance" "master" {
  name             = "main-${random_id.db_name_suffix.hex}"
  database_version = "POSTGRES_13"
  region           = local.main_region

  depends_on = [google_service_networking_connection.private_vpc_connection]

  settings {
    tier = "db-custom-2-7680"
    ip_configuration {
      ipv4_enabled    = false
      private_network = google_compute_network.default.id
    }
  }
}

resource "random_password" "password" {
  length           = 16
  special          = false
  upper            = false
}

resource "random_password" "postgres" {
  length           = 16
  special          = false
  upper            = false
}

resource "google_sql_user" "user1" {
  name     = "staging"
  instance = google_sql_database_instance.master.name
  password = random_password.password.result
}

resource "google_sql_user" "postgres" {
  name     = "postgres"
  instance = google_sql_database_instance.master.name
  password = random_password.postgres.result
}
