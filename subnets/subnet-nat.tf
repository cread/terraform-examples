resource "aws_subnet" "nat" {
  count             = var.zone_count
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = cidrsubnet(var.vpc_cidr, var.cidr_newbits_nat, count.index + var.cidr_offset_nat)
  availability_zone = data.aws_availability_zones.available.names[count.index]

  map_public_ip_on_launch = false

  tags = {
    Name = "example-subnets-nat-${data.aws_availability_zones.available.names[count.index]}"
  }
}

resource "aws_eip" "nat" {
  count      = var.zone_count
  depends_on = [aws_internet_gateway.igw]

  tags = {
    Name = "example-subnets-nat-${data.aws_availability_zones.available.names[count.index]}"
  }
}

resource "aws_nat_gateway" "ngw" {
  count         = var.zone_count
  allocation_id = aws_eip.nat[count.index].id
  subnet_id     = aws_subnet.public[count.index].id

  tags = {
    Name = "example-subnets-nat-${data.aws_availability_zones.available.names[count.index]}"
  }
}

resource "aws_route_table" "nat" {
  count  = var.zone_count
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "example-subnets-nat-${data.aws_availability_zones.available.names[count.index]}"
  }
}

resource "aws_route" "nat-default" {
  count                  = var.zone_count
  route_table_id         = aws_route_table.nat[count.index].id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.ngw[count.index].id
}

resource "aws_route_table_association" "nat" {
  count          = var.zone_count
  subnet_id      = aws_subnet.nat[count.index].id
  route_table_id = aws_route_table.nat[count.index].id
}