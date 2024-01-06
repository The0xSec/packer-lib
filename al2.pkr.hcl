packer {
    required_plugins {
        amazon = {
            version = ">= 0.0.2"
            source  = "github.com/hashicorp/amazon"
        }
    }
}

source "amazon-ebs" "al2-docker" {
    ami_name      = "centos-7-docker-{{timestamp}}"
    instance_type = "t2.micro"
    region        = "us-east-1"
    source_ami_filter {
        filters = {
            image-id                = "ami-0f34c5ae932e6f0e4"
        }
        most_recent = true
        owners = ["137112412989"]
    }

    ssh_username = "ec2-user"
}

build {
    name = "al2-docker"
    sources = [
        "source.amazon-ebs.al2-docker"
    ]

    provisioner "shell" {
        inline = [
            "sudo yum update -y",
            "sudo yum install -y yum-utils device-mapper-persistent-data lvm2",
            "sudo yum install docker -y",
            "sudo yum install python3-pip -y",
            "sudo systemctl start docker",
            "sudo systemctl enable docker",
            "sudo usermod -aG docker ec2-user",

        ]
    }
}
