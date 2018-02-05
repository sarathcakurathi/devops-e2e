resource "aws_instance" "devops_instance" {
  instance_type = "t2.micro"
  vpc_security_group_ids = [ "${aws_security_group.vault-sg.id}" ]
  associate_public_ip_address = true
  key_name = "devops_access_key"
  user_data = "${file("../scripts/user_setup.sh")}"
  iam_instance_profile = "${aws_iam_instance_profile.devops-e2e.name}"
  ami = "ami-10547475"
  availability_zone = "${var.availability_zone_id}"
  subnet_id = "${var.subnet_id}"
  depends_on = ["aws_iam_instance_profile.devops-e2e"]
}