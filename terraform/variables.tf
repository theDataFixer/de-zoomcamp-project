#  For variable 'project', you'll be asked to provide the value for the `project` variable
variable "project" {
  type        = string
  description = "The ID of the project in which to provision resources."
}

variable "region" {
  type        = string
  description = "The region in which to provision resources."
  default     = "us-west1"
}

variable "credentials_file" {
  type        = string
  description = "Path to GCP credentials file"
  default     = "/home/my/amazing/path/for/my/credentials.json" # ADD YOUR CREDENTIALS JSON FILE HERE
}
