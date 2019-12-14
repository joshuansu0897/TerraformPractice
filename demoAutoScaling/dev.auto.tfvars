ami_id="ami-0267191abd0165f0e"
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
elb_sg_name="demo-rules-elb"
elb_sg_ingress=[
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
elb_sg_egress=[
    {
        from_port= 0
        to_port= 0
        protocol= "-1"
        cidr_blocks= ["0.0.0.0/0"]
    }
]
name_elb="elb-test-from-terraform"
min_size=1
desired_capacity=2
max_size=3