resource "aws_internet_gateway" "matte-igw" {
    vpc_id = "${aws_vpc.matte-vpc.id}"
    tags = {
        Name = "matte-igw"
    }
}

resource "aws_route_table" "matte-public-crt" {
    vpc_id = "${aws_vpc.matte-vpc.id}"

    route {
        cidr_block = "0.0.0.0/0"

        gateway_id = "${aws_internet_gateway.matte-igw.id}"
    }
    tags = {
        Name = "matte-public-crt"
    }
}

resource "aws_route_table_association" "matte-crta-public-subnet-1" {
    subnet_id = "${aws_subnet.matte-subnet-public-1.id}"
    route_table_id = "${aws_route_table.matte-public-crt.id}"
}

resource "aws_route_table_association" "matte-crta-public-subnet-2" {
    subnet_id = "${aws_subnet.matte-subnet-public-2.id}"
    route_table_id = "${aws_route_table.matte-public-crt.id}"
}

resource "aws_security_group" "ssh-allowed" {
    vpc_id = "${aws_vpc.matte-vpc.id}"
    
    egress {
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        // This means, all ip address are allowed to ssh ! 
        // Do not do it in the production. 
        // Put your office or home address in it!
        cidr_blocks = ["0.0.0.0/0"]
    }
    //If you do not add this rule, you can not reach the NGIX  
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {
        Name = "ssh-allowed"
    }
}