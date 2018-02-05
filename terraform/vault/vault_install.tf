resource "null_resource" "vault_install" {
  
  provisioner "file" {
    source      = "../scripts/vault_install.sh"
    destination = "/home/ubuntu/vault_install.sh"
	
	connection {
		host	 = "${aws_instance.devops_instance.public_ip}"
		type     = "ssh"
		user     = "ubuntu"
		private_key = "${file("/home/sarath/devops_access_key.pem")}"
		agent	 = false
		timeout	 = "30s"
	}
  }
  
  provisioner "remote-exec" {
    inline = [
      "chmod +x /home/ubuntu/vault_install.sh",
      "sudo /home/ubuntu/vault_install.sh",
    ]
	connection {
		host	 = "${aws_instance.devops_instance.public_ip}"
		type     = "ssh"
		user     = "ubuntu"
		private_key = "${file("/home/sarath/devops_access_key.pem")}"
		agent	 = false
		timeout	 = "30s"
	}
  }
}
