/*
resource "aws_route53_record" "cycloid" {
  provider = aws.network
  zone_id  = data.aws_route53_zone.private.zone_id
  name     = "poc-cycloid-wordpress.shared-services-noprd.aws.cld.cma-cgm.com."
  type     = "A"

  alias {
    name                   = module.asg.alb_dns_name
    zone_id                = module.asg.alb_zone_id
    evaluate_target_health = true
  }
}
*/