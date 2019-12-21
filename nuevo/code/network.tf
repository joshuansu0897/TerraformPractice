resource "aws_internet_gateway" "gateway" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "Internet Gateway"
  }
}

resource "aws_route_table" "route_table_public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gateway.id
  }

  tags = {
    Name = "FrontEnd Subnet"
  }
}

resource "aws_route_table_association" "route_table_public_association" {
  count = length(aws_subnet.public_subnets)
  subnet_id = element(aws_subnet.public_subnets.*.id, count.index)
  route_table_id = aws_route_table.route_table_public.id
  depends_on = [aws_route_table.route_table_public]
}

resource "aws_eip" "nat" {
  count = length(aws_subnet.public_subnets)
  vpc = true
}

resource "aws_nat_gateway" "nat" {
  count = length(aws_subnet.public_subnets)
  allocation_id = element(aws_eip.nat.*.id, count.index)
  subnet_id = element(aws_subnet.public_subnets.*.id, count.index)
  depends_on = [aws_internet_gateway.gateway]
}

resource "aws_route_table" "route_table_private" {
  count = length(aws_nat_gateway.nat)
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = element(aws_nat_gateway.nat.*.id, count.index)
  }

  tags = {
    Name = "BackEnd Subnet - ${count.index + 1}"
  }
}

resource "aws_route_table_association" "route_table_private_association" {
  count = length(aws_subnet.private_subnets)
  subnet_id = element(aws_subnet.private_subnets.*.id, count.index)
  route_table_id = element(aws_route_table.route_table_private.*.id, count.index)
  depends_on = [aws_route_table.route_table_private]
}