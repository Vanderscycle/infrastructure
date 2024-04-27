locals {
  bucket_name = "${var.env}-${var.region}-terraform-state"
}

module "s3" {

  # source = "terraform-aws-modules/s3-bucket/aws"
  source = "./../../../../modules/s3_bucket"

  bucket_name = local.bucket_name
  acl    = var.acl

  control_object_ownership = true
  object_ownership         = "ObjectWriter"

  versioning = var.versioning

}
