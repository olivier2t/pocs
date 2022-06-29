resource "aws_key_pair" "cloud-init" {
  key_name   = "${var.customer}-${var.project}-${var.env}-cloud-init-key"
  public_key = var.keypair_public
}