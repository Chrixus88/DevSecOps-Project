terraform {
   backend "s3" {
     bucket = "chrixus88-netbuck"
     key    = "dev/terraform.tfstate"
     region = "us-east-1"
   }
}
