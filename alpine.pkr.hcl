packer {
    required_plugins {
        docker = {
            version = ">= 0.0.7"
            source  = "github.com/hashicorp/docker"
        }
    }
}

source "docker" "alpine" {
    image  = "alpine:latest"
    commit = true
}

build {
    name = "custom-alpine"
    sources = [
        "docker.docker.alpine"
    ]


    provisioner "shell" {
        environment_vars = [
            "PACKER_BUILD_NAME={{.BuildName}}",
        ]
        inline = [
            "echo 'Hello, World!'",
            "echo 'Build name: 0.0.1'",
        ]
    }

    post-processors{
        post-processor "docker-tag" {
            repository = "ephemeralcodex/test"
            tag = ["0.0.1"]
            force = true
        }
        post-processor "docker-push" {}
    }
}
