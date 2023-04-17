resource "aws_instance" "Instance" {
              count = 1
                ami = var.imagename
  #availability_zone = "us-east-1a"
      instance_type = "t2.micro"
           key_name = "Lapkey"
          subnet_id = "${element(aws_subnet.PUBLIC-SUBNET.*.id,count.index)}"
  vpc_security_group_ids = "${aws_security_group.allow_all.*.id}"
  associate_public_ip_address = true
  tags ={
    Name = "${var.vpc_name}-server-${count.index+1}"
  }
}