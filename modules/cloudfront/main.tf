

resource "aws_acm_certificate" "cert" {
  domain_name       = var.additional_domain_name
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}

resource "local_file" "dns_validation_records" {
  content = join("\n", [for option in aws_acm_certificate.cert.domain_validation_options : "${option.resource_record_name} ${option.resource_record_value}"])
  filename = "${path.module}/dns_validation_records.txt"
}

#creating Cloudfront distribution :
resource "aws_cloudfront_distribution" "my_distribution" {
  enabled             = true
  aliases             =  [var.additional_domain_name]
  origin {
    domain_name = var.alb_domain_name
    origin_id   = var.alb_domain_name

    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "http-only"
      origin_ssl_protocols   = ["TLSv1.2"]
    }
  }
  default_cache_behavior {
    allowed_methods        = ["GET", "HEAD", "OPTIONS", "PUT", "POST", "PATCH", "DELETE"]
    cached_methods         = ["GET", "HEAD", "OPTIONS"]
    target_origin_id       = var.alb_domain_name
    viewer_protocol_policy = "redirect-to-https"
    forwarded_values {
      headers      = []
      query_string = true
      cookies {
        forward = "all"
      }
    }
  }
  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }
  tags = {
    Name = var.project_name
  }
  viewer_certificate {
    acm_certificate_arn      = aws_acm_certificate.cert.arn
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.2_2021"
  }
}