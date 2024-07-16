data "terraform_remote_state" "instanceTemplates" {
  backend = "local"

  config = {
    path = "../../../../../generated/google/trabalho-uece/instanceTemplates/us-central1/terraform.tfstate"
  }
}
