resource "google_project_iam_member" "tfer--roles-002F-compute-002E-serviceAgentserviceAccount-003A-service-786239718775-0040-compute-system-002E-iam-002E-gserviceaccount-002E-com" {
  member  = "serviceAccount:service-786239718775@compute-system.iam.gserviceaccount.com"
  project = "trabalho-uece"
  role    = "roles/compute.serviceAgent"
}

resource "google_project_iam_member" "tfer--roles-002F-editorserviceAccount-003A-786239718775-0040-cloudservices-002E-gserviceaccount-002E-com" {
  member  = "serviceAccount:786239718775@cloudservices.gserviceaccount.com"
  project = "trabalho-uece"
  role    = "roles/editor"
}

resource "google_project_iam_member" "tfer--roles-002F-editorserviceAccount-003A-786239718775-compute-0040-developer-002E-gserviceaccount-002E-com" {
  member  = "serviceAccount:786239718775-compute@developer.gserviceaccount.com"
  project = "trabalho-uece"
  role    = "roles/editor"
}

resource "google_project_iam_member" "tfer--roles-002F-ownerserviceAccount-003A-786239718775-compute-0040-developer-002E-gserviceaccount-002E-com" {
  member  = "serviceAccount:786239718775-compute@developer.gserviceaccount.com"
  project = "trabalho-uece"
  role    = "roles/owner"
}

resource "google_project_iam_member" "tfer--roles-002F-owneruser-003A-alberto-002E-neto94-0040-gmail-002E-com" {
  member  = "user:alberto.neto94@gmail.com"
  project = "trabalho-uece"
  role    = "roles/owner"
}
