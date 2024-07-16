data "terraform_remote_state" "backendServices" {
  backend = "local"

  config = {
    path = "../../../../../generated/google/trabalho-uece/backendServices/us-central1/terraform.tfstate"
  }
}

data "terraform_remote_state" "regionBackendServices" {
  backend = "local"

  config = {
    path = "../../../../../generated/google/trabalho-uece/regionBackendServices/us-central1/terraform.tfstate"
  }
}
