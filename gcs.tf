data "google_storage_project_service_account" "gcs_account" {
}

# we need to give default GCS service account a permission to use KMS key
# only then GCS bucket can encrypt files using that key
resource "google_kms_crypto_key_iam_binding" "gcs" {

  crypto_key_id = google_kms_crypto_key.terraform-state.id
  role          = "roles/cloudkms.cryptoKeyEncrypterDecrypter"

  members = ["serviceAccount:${data.google_storage_project_service_account.gcs_account.email_address}"]
}

resource "google_storage_bucket" "terraform-state" {
  name          = "terraform-state-examplecom"
  location      = "US"
  force_destroy = true

  versioning {
    enabled = true
  }

  uniform_bucket_level_access = true

  depends_on = [google_kms_crypto_key_iam_binding.gcs]

  encryption {
    default_kms_key_name = google_kms_crypto_key.terraform-state.id
  }
}

# we need to specify who can read files from terrraform-state bucket explicitly
resource "google_storage_bucket_iam_binding" "readers" {
  bucket = google_storage_bucket.terraform-state.name
  role = "roles/storage.objectViewer"
  members = [
    "user:konrad@ulam.io",
  ]
}
