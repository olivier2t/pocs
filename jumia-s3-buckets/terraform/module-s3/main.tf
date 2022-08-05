resource "aws_s3_bucket" "bucket" {

  for_each = var.s3_buckets == null ? {} : {for bucket in var.s3_buckets: bucket.name => bucket}

  bucket = each.value.name

  tags = merge({
    Name        = each.value.name
    Environment = var.environment
  }, each.value.tags)
}


resource "aws_s3_bucket_acl" "bucket_acl" {

  for_each = var.s3_buckets == null ? {} : {for bucket in var.s3_buckets: bucket.name => bucket}

  bucket = aws_s3_bucket.bucket[each.value.name].id
  acl    = each.value.acl
}


resource "aws_s3_bucket_versioning" "bucket_versioning" {

  for_each = var.s3_buckets == null ? {} : {for bucket in var.s3_buckets: bucket.name => bucket}

  bucket = aws_s3_bucket.bucket[each.value.name].id
  versioning_configuration {
    status = each.value.versioning
  }
}


resource "aws_s3_bucket_public_access_block" "bucket_public_access" {

  for_each = var.s3_buckets == null ? {} : {for bucket in var.s3_buckets: bucket.name => bucket}

  bucket = aws_s3_bucket.bucket[each.value.name].id

  block_public_acls       = each.value.block_public_access
  block_public_policy     = each.value.block_public_access
  ignore_public_acls      = each.value.block_public_access
  restrict_public_buckets = each.value.block_public_access
}




# S3 BUCKET OBJECT

resource "aws_s3_object" "bucket_objects" {
  for_each = var.s3_bucket_objects == null ? {} : {for bucket_objects in var.s3_bucket_objects: "${bucket_objects.name}:${bucket_objects.key}" => bucket_objects}

  bucket = each.value.name
  acl    = each.value.acl
  key    = each.value.key #"keys/"
  source = lookup(each.value, "source", "/dev/null")
}


# CREATE WEBSITE

resource "aws_s3_bucket_website_configuration" "create_website" {
  for_each = var.s3_buckets == null ? {} : {for bucket in var.s3_buckets: bucket.name => bucket
  if bucket.create_website == true }

  bucket = each.value.name


  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "index.html"
  }

  depends_on = [
    aws_s3_bucket.bucket
  ]
}


#S3-VPC POLICY ATTACHMENT

resource "aws_s3_bucket_policy" "allow_access_from_vpcs" {
  for_each = var.s3_buckets == null ? {} : {for bucket in var.s3_buckets: bucket.name => bucket
  if bucket.attach_vpc_policy == true }

  bucket = each.value.name
  policy = data.aws_iam_policy_document.vpc_policy_document[each.value.name].json

  depends_on = [
    aws_s3_bucket.bucket
  ]
}


data "aws_iam_policy_document" "vpc_policy_document" {
  for_each = var.s3_buckets == null ? {} : {for bucket in var.s3_buckets: bucket.name => bucket
  if bucket.attach_vpc_policy == true }

  statement {
    sid = "Enable s3 Bucket - VPC Permissions"
    effect = "Allow"

    actions = [
        "s3:ListBucket",
        "s3:GetObject"
    ]

    resources = [
      "arn:aws:s3:::${each.value.name}",
      "arn:aws:s3:::${each.value.name}/*"
    ]

    principals {
      type = "AWS"
      identifiers = [
        for account_id in each.value.principal_account_ids:
        account_id
      ]
    }

    condition {
      test = "StringEquals"
      variable = "aws:sourceVpc"
      values = [ 
        for vpc_id in each.value.vpc_ids:
        vpc_id
      ]

    }
  }

    
}



#USER POLICY ATTACHMENT


resource "aws_iam_user" "user" {
  for_each = var.s3_buckets == null ? {} : {for bucket in var.s3_buckets: bucket.name => bucket
  if bucket.create_s3_user == true }

  name = lookup(each.value, "s3_user_name", each.value.name)
}

resource "aws_iam_policy" "policy" {
  for_each = var.s3_buckets == null ? {} : {for bucket in var.s3_buckets: bucket.name => bucket
  if bucket.attach_user_policy == true }

  name        = "${each.value.name}-s3userpolicy"
  policy      = data.aws_iam_policy_document.user_policy_document[each.value.name].json
}




data "aws_iam_policy_document" "user_policy_document" {
  for_each = var.s3_buckets == null ? {} : {for bucket in var.s3_buckets: bucket.name => bucket
  if bucket.attach_user_policy == true }

  statement {
    sid = "Enables3BucketUserPermissions"
    effect = "Allow"

    actions = [
      "s3:*"
    ]

    resources = [
      "arn:aws:s3:::${each.value.name}",
      "arn:aws:s3:::${each.value.name}/*"
    ]

  }

    
}


resource "aws_iam_user_policy_attachment" "policy-attach" {
  for_each = var.s3_buckets == null ? {} : {for bucket in var.s3_buckets: bucket.name => bucket
  if bucket.attach_user_policy == true }

  user       = each.value.create_s3_user == true ? aws_iam_user.user[each.value.name].name : each.value.s3_user_name
  policy_arn = aws_iam_policy.policy[each.value.name].arn
}