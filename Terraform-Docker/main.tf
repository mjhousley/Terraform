#Add Docker provider
terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "2.16.0"
    }
  }
}

provider "docker" {
  host = "unix:///var/run/docker.sock"
}

#Image to be used by container
resource "docker_image" "terraform-centos" {
  name         = "centos:7"
  keep_locally = true
}

# Create a container
resource "docker_container" "centos" {
  image   = docker_image.terraform-centos.latest
  name    = "terraform-centos"
  start   = true
  command = ["/bin/sleep", "500"]
}