data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "tcb_blog_ec2" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  subnet_id = "${aws_subnet.matte-subnet-public-1.id}"
  vpc_security_group_ids = ["${aws_security_group.ssh-allowed.id}"]
  key_name = "${aws_key_pair.london-region-key-pair.id}"

  provisioner "file" {
        source = "nginx.sh"
        destination = "/tmp/nginx.sh"
    }
    provisioner "remote-exec" {
        inline = [
             "chmod +x /tmp/nginx.sh",
             "sudo /tmp/nginx.sh"
        ]
    }
    connection {
        user = "${var.EC2_USER}"
        private_key = "${file("${var.PRIVATE_KEY_PATH}")}"
    }

  tags = {
    Name = "blogserver01"
  }
}

resource "aws_key_pair" "london-region-key-pair" {
    key_name = "london-region-key-pair"
    public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC/8uxXyFXGFqcG+eJTqHK0GUJ8q7h45bEl51HN+CNF4Ci0+yQtqgS4mOiSW2rqCDE2KgtY/keGWevHVvTAza8rPBczl2oYYFmJD7W6NwXXYF6jv4Wi2oXsE1rXC1T2HRAqdoDDmIHEH4oX4ayw/eesNDO0HyisAR7Whqhkb7BlYbIow8l+RVzzLKbmCtqfsjEY4UZureApsntKBbp9sc0uiscr+XiPO9oB7y6tvadgQjk8Uu1NuyWccSaeMIJn/vrWWnK41TZBQ0Y9+FJE1YYr9kgi1OY6ye18GHAWjAJfcL/WjhLsz32xUIuASjFGvI167n8tyh+0glPqA3fb93DZb4gWjC/6SODuxs/fxHpq7sZmPtBgmy0qxmPLVTYGQvdhgh8WhLZ8k+DcJc9UkANWrcWLLG/+IbWhr+ccZcZCe/0i1DPQq/wzXeswLu06BTqt0GmLzV3SlLUenzglumhXVx8QW854W7snHgxi5Z/uhOip45CZxqPsvIoeL3wm4NU= matte@matte"
}