resource "google_dns_managed_zone" "examplecom" {
  description = ""
  dns_name = "example.com."
  force_destroy = false
  name = "examplecom"
  project = local.project
  visibility = "public"
}

resource "google_dns_record_set" "staging" {
  name         = "staging.example.com."
  managed_zone = google_dns_managed_zone.examplecom.name
  type         = "CNAME"
  ttl          = 300

  rrdatas = ["cname.vercel-dns.com."]
}

resource "google_dns_record_set" "wwwstaging" {
  name         = "wwwstaging.example.com."
  managed_zone = google_dns_managed_zone.examplecom.name
  type         = "CNAME"
  ttl          = 300

  rrdatas = ["cname.vercel-dns.com."]
}

resource "google_dns_record_set" "www" {
  name         = "www.example.com."
  managed_zone = google_dns_managed_zone.examplecom.name
  type         = "CNAME"
  ttl          = 300

  rrdatas = ["proxy-ssl.webflow.com."]
}

resource "google_dns_record_set" "apistaging" {
  name         = "api.staging.example.com."
  managed_zone = google_dns_managed_zone.examplecom.name
  type         = "A"
  ttl          = 300

  rrdatas = ["34.117.49.95"]
}
