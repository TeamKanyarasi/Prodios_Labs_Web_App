resource "aws_route53_zone" "main" {
  name = "prodioslabswebapp.com"
}

resource "aws_route53_record" "www" {
  zone_id = aws_route53_zone.main.zone_id
  name    = "www.${aws_route53_zone.main.name}"
  type    = "A"

  alias {
    name                   = var.domain_name
    zone_id                = var.hosted_zone_id
    evaluate_target_health = false
  }
}