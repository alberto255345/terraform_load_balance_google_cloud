resource "google_project" "tfer--trabalho-uece" {
  auto_create_network = "true"
  billing_account     = "01E5A9-365F15-550DA0"
  name                = "Trabalho-UECE"
  project_id          = "trabalho-uece"
}
