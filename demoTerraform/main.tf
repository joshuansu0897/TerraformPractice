provider "aws"{
    region=var.region
}

resource "aws_security_group" "ssh_conection" {
    name = var.ssh_conection_name
    dynamic "ingress" {
        for_each = var.ssh_conection_ingress
        content {
            from_port=ingress.value.from_port
            to_port=ingress.value.to_port
            protocol=ingress.value.protocol
            cidr_blocks=ingress.value.cidr_blocks
        }
    }
}

resource "aws_instance" "demo-instance" {
    ami=var.ami_id
    instance_type=var.instance_type
    tags=var.tags
    security_groups=["${aws_security_group.ssh_conection.name}"]
}
