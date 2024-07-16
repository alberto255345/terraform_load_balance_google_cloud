data "terraform_remote_state" "healthChecks" {
  backend = "local"

  config = {
    path = "../../../../../generated/google/trabalho-uece/healthChecks/us-central1/terraform.tfstate"
  }
}

data "terraform_remote_state" "instanceGroupManagers" {
  backend = "local"

  config = {
    path = "../../../../../generated/google/trabalho-uece/instanceGroupManagers/us-central1/terraform.tfstate"
  }
}

data "terraform_remote_state" "regionInstanceGroupManagers" {
  backend = "local"

  config = {
    path = "../../../../../generated/google/trabalho-uece/regionInstanceGroupManagers/us-central1/terraform.tfstate"
  }
}
