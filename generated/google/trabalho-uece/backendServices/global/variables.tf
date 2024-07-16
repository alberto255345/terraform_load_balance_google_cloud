data "terraform_remote_state" "healthChecks" {
  backend = "local"

  config = {
    path = "../../../../../generated/google/trabalho-uece/healthChecks/global/terraform.tfstate"
  }
}

data "terraform_remote_state" "regionInstanceGroupManagers" {
  backend = "local"

  config = {
    path = "../../../../../generated/google/trabalho-uece/regionInstanceGroupManagers/global/terraform.tfstate"
  }
}
