data "aws_route53_zone" "hosted_zone" {
  name = var.core_hosted_zone
}

resource "aws_route53_record" "cycloid-core-console" {
  name    = var.core_domain_console
  zone_id = data.aws_route53_zone.hosted_zone.zone_id
  type    = "A"
  alias {
    name                   = aws_lb.cycloid.dns_name
    zone_id                = aws_lb.cycloid.zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "cycloid-core-api" {
  name    = var.core_domain_api
  zone_id = data.aws_route53_zone.hosted_zone.zone_id
  type    = "A"
  alias {
    name                   = aws_lb.cycloid.dns_name
    zone_id                = aws_lb.cycloid.zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "cycloid-core-concourse" {
  name    = var.core_domain_concourse
  zone_id = data.aws_route53_zone.hosted_zone.zone_id
  type    = "A"
  alias {
    name                   = aws_lb.cycloid-concourse.dns_name
    zone_id                = aws_lb.cycloid-concourse.zone_id
    evaluate_target_health = true
  }
}

resource "aws_acm_certificate" "cycloid-core-console" {
  domain_name       = "${var.core_domain_console}.${var.core_hosted_zone}"
  validation_method = "DNS"

  tags = merge(local.merged_tags, {
    Name = "${var.customer}-${var.project}-${var.env}-cycloid-core-console"
    role = "cycloid-core-console"
  })

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route53_record" "cycloid-core-console-validation" {
  for_each = {
    for dvo in aws_acm_certificate.cycloid-core-console.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = aws_route53_zone.hosted_zone.zone_id
}

resource "aws_acm_certificate_validation" "cycloid-core-console-validation" {
  certificate_arn         = aws_acm_certificate.cycloid-core-console.arn
  validation_record_fqdns = [for record in aws_route53_record.cycloid-core-console-validation : record.fqdn]
}

resource "aws_acm_certificate" "cycloid-core-api" {
  domain_name       = "${var.core_domain_api}.${var.core_hosted_zone}"
  validation_method = "DNS"

  tags = merge(local.merged_tags, {
    Name = "${var.customer}-${var.project}-${var.env}-cycloid-core-api"
    role = "cycloid-core-api"
  })

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route53_record" "cycloid-core-api-validation" {
  for_each = {
    for dvo in aws_acm_certificate.cycloid-core-api.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = aws_route53_zone.hosted_zone.zone_id
}

resource "aws_acm_certificate_validation" "cycloid-core-api-validation" {
  certificate_arn         = aws_acm_certificate.cycloid-core-api.arn
  validation_record_fqdns = [for record in aws_route53_record.cycloid-core-api-validation : record.fqdn]
}

resource "aws_acm_certificate" "cycloid-core-concourse" {
  domain_name       = "${var.core_domain_concourse}.${var.core_hosted_zone}"
  validation_method = "DNS"

  tags = merge(local.merged_tags, {
    Name = "${var.customer}-${var.project}-${var.env}-cycloid-core-concourse"
    role = "cycloid-core-concourse"
  })

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route53_record" "cycloid-core-concourse-validation" {
  for_each = {
    for dvo in aws_acm_certificate.cycloid-core-concourse.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = aws_route53_zone.hosted_zone.zone_id
}

resource "aws_acm_certificate_validation" "cycloid-core-concourse-validation" {
  certificate_arn         = aws_acm_certificate.cycloid-core-concourse.arn
  validation_record_fqdns = [for record in aws_route53_record.cycloid-core-concourse-validation : record.fqdn]
}
