resource "google_service_account" "default" {
  account_id   = "default"
  display_name = "Default Service Account"
}

resource "google_service_account" "ci" {
  account_id   = "github-actions"
  display_name = "Github Actions"
}

resource "google_service_account_key" "ci" {
  service_account_id = google_service_account.ci.name
  public_key_type    = "TYPE_X509_PEM_FILE"
}

resource "google_project_iam_binding" "project" {
  project = local.project
  role    = "roles/editor"
  members = [
    "serviceAccount:${google_service_account.default.email}",
    "serviceAccount:${google_service_account.ci.email}",
    "serviceAccount:179971505874-compute@developer.gserviceaccount.com",
    "serviceAccount:179971505874@cloudservices.gserviceaccount.com",
  ]
}
