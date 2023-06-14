resource "aws_vpc" "matte-vpc" {
    cidr_block = "10.0.0.0/16"
    enable_dns_support = "true"
    enable_dns_hostnames = "true"
    instance_tenancy = "default"

    tags = {
        Name = "matte-vpc"
    }
}

resource "aws_subnet" "matte-subnet-public-1" {
    vpc_id = "${aws_vpc.matte-vpc.id}"
    cidr_block = "10.0.1.0/24"
    map_public_ip_on_launch = "true"
    availability_zone = "us-east-1a"

    tags = {
        Name = "prod-subnet-public-1"
    }

}

resource "aws_subnet" "matte-subnet-public-2" {
    vpc_id = "${aws_vpc.matte-vpc.id}"
    cidr_block = "10.0.2.0/24"
    map_public_ip_on_launch = "true"
    availability_zone = "us-east-1b"

    tags = {
        Name = "prod-subnet-public-2"
    }

}

resource "aws_subnet" "matte-subnet-private-1" {
    vpc_id = "${aws_vpc.matte-vpc.id}"
    cidr_block = "10.0.3.0/24"
    map_public_ip_on_launch = "true"
    availability_zone = "us-east-1a"

    tags = {
        Name = "matte-subnet-private-1"
    }

}

resource "aws_subnet" "matte-subnet-private-2" {
    vpc_id = "${aws_vpc.matte-vpc.id}"
    cidr_block = "10.0.4.0/24"
    map_public_ip_on_launch = "true"
    availability_zone = "us-east-1b"

    tags = {
        Name = "matte-subnet-private-2"
    }

}