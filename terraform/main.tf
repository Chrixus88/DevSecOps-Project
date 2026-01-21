resource "aws_instance" "netflix" {
  ami           = "ami-0b6c6ebed2801a5cb"
  instance_type = "t2.xlarge"

  tags = {
    Name = "HelloWorld"
  }
}

resource "aws_s3_bucket" "netbuck" {
  bucket = "chrixus88-netbuck"
  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}
