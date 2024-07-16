data "terraform_remote_state" "networks" {
  backend = "local"

  config = {
    path = "../../../../../generated/google/trabalho-uece/networks/us-central1/terraform.tfstate"
  }
}

data "terraform_remote_state" "subnetworks" {
  backend = "local"

  config = {
    path = "../../../../../generated/google/trabalho-uece/subnetworks/us-central1/terraform.tfstate"
  }
}
