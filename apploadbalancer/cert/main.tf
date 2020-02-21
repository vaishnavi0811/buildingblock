variable "domainName" {
  type = string
}
variable "organization" {
  type = string
}
variable "algorithm" {
  type = string
}

resource "tls_private_key" "selfsigned" {
  algorithm = "RSA"
}
resource "tls_self_signed_cert" "this_cert" {
  key_algorithm   = "RSA"
  private_key_pem = tls_private_key.selfsigned.private_key_pem
  subject {
    common_name  = "example.com"
    organization = "ACME Examples, Inc"
  }

  validity_period_hours = 180
  dns_names             = ["cloudlego.com"]
  allowed_uses = [
    "key_encipherment",
    "digital_signature",
    "server_auth",
  ]
}
resource "aws_acm_certificate" "the_cert" {
  private_key      = tls_private_key.this_cert.private_key_pem
  certificate_body = tls_self_signed_cert.this_cert.cert_pem
}
output "certARN" {
  value = aws_acm_certificate.the_cert.arn
}
