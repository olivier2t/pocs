data "aws_route53_zone" "selected" {
  name         = "${var.webapp_domain}."
}

resource "aws_route53_record" "webapp" {
  zone_id = data.aws_route53_zone.selected.zone_id
  name    = "${var.webapp_subdomain}.${data.aws_route53_zone.selected.name}"
  type    = "A"
  ttl     = "300"
  records = [aws_instance.webapp.public_ip]
}