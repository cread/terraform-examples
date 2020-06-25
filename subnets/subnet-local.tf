resource "aws_subnet" "local" {
  count             = var.zone_count
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = cidrsubnet(var.vpc_cidr, var.cidr_newbits_local, count.index + var.cidr_offset_local)
  availability_zone = data.aws_availability_zones.available.names[count.index]

  map_public_ip_on_launch = false

  tags = {
    Name = "example-subnets-local-${data.aws_availability_zones.available.names[count.index]}"
  }
}

resource "aws_route_table" "local" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "example-subnets-local"
  }
}

resource "aws_route_table_association" "local" {
  count          = var.zone_count
  subnet_id      = aws_subnet.local[count.index].id
  route_table_id = aws_route_table.local.id
}