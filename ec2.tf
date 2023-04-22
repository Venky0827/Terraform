resource "aws_instance" "web-1" {
    ami = "${data.aws_ami.my_ami.id}"
    availability_zone = "us-east-1a"
    instance_type = "t2.nano"
    key_name = "LaptopKey"
    subnet_id = "${aws_subnet.subnet1-public.id}"
    vpc_security_group_ids = ["${aws_security_group.allow_all.id}"]
    associate_public_ip_address = true
    private_ip = "10.1.1.220"	
    tags = {
        Name = "Docker-Host-2"
        Env = "Prod"
        Owner = "Sree"
    }
}