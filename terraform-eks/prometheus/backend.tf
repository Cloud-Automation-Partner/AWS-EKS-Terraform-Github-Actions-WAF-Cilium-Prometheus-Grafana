terraform {
  backend "s3" {
    bucket = "" # Replace with your actual S3 bucket name
    key    = "Prometheus/terraform.tfstate"
    region = "us-west-2"
  }
}
