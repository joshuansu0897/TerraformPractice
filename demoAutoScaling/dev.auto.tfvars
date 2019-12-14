ami_id="ami-079d0b3aa4a1ac8eb"
instance_type="t2.micro"
region="us-east-2"
asg_sg_name="demo-rules"
asg_sg_ingress=[
    {
        from_port=22
        to_port=22
        protocol="tcp"
        cidr_blocks=["0.0.0.0/0"]
    },
    {
        from_port=80
        to_port=80
        protocol="tcp"
        cidr_blocks=["0.0.0.0/0"]
    }
]
asg_sg_egress=[
    {
        from_port= 0
        to_port= 0
        protocol= "-1"
        cidr_blocks= ["0.0.0.0/0"]
    }
]