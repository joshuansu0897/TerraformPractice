provider "aws"{
    region=var.region
}

module "app" {
    source = "./modulos/instances"
    ami_id=var.ami_id
    instance_type=var.instance_type
    tags=var.tags
    region=var.region
    ssh_conection_name=var.ssh_conection_name
    ssh_conection_ingress=var.ssh_conection_ingress
}