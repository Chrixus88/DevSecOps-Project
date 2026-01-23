resource "aws_key_pair" "ec2_key" {
  key_name   = "terraform-key"
  public_key = file("terraform-key.pub")
}


resource "aws_instance" "netflix" {
  ami           = "ami-0b6c6ebed2801a5cb"
  instance_type = "t2.xlarge"
  key_name = aws_key_pair.ec2_key.key_name
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
