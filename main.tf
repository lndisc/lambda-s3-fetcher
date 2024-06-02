resource "aws_s3_bucket" "this" {
  bucket = var.bucket_name
}

resource "aws_s3_object" "hello_world" {
  bucket = aws_s3_bucket.this.bucket
  key    = "hello-world.txt"
  source = "${path.module}/files/hello-world.txt"
  acl    = "private"
}
