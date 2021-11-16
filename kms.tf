resource "google_kms_key_ring" "default" {
  name     = "default"
  location = "global"
}

resource "google_kms_key_ring" "regional" {
  name     = "regional"
  location = "us"
}

resource "google_kms_crypto_key" "terraform-state" {
  name            = "terraform-state"
  key_ring        = google_kms_key_ring.regional.id
  rotation_period = "7776000s"

  lifecycle {
    prevent_destroy = true
  }
}

resource "google_kms_crypto_key" "k8s-envs-prod" {
  name            = "k8s-envs-prod"
  key_ring        = google_kms_key_ring.default.id
  rotation_period = "7776000s"

  lifecycle {
    prevent_destroy = true
  }
}

resource "google_kms_crypto_key" "k8s-envs-staging" {
  name            = "k8s-envs-staging"
  key_ring        = google_kms_key_ring.default.id
  rotation_period = "7776000s"

  lifecycle {
    prevent_destroy = true
  }
}
