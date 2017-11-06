resource "google_project_services" "project_services" {
  project  = "${var.project_id}"
  services = ["speech.googleapis.com"]
}
