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
