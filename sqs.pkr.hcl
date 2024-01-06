packer {

 required_plugins {
  	docker = {
		version = ">= 1.0.8"
		source = "github.com/hashicorp/docker"
		}
	}
}


source "docker" "alpine" {
  image = "alpine"
  commit = true
}

build {
  name = "learn-alpine"
  sources = [
    "source.docker.alpine"
  ]
  post-processors {
  post-processor "docker-tag" {
    repository = "registry.gitlab.com/0xvmx1/sol"
    tag = ["latest"]
  }

  post-processor "docker-push" {
    login = true
    login_server = "registry.gitlab.com/0xvmx1/sol"
    login_username = "0xvmx@proton.me"
    login_password = "Evelyn2021!!"
  }
}
}
