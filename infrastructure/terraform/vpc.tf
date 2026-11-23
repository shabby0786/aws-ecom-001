
data "aws_availability_zones" "available" {
  state = "available"
}

locals {
  availability_zones = slice(
    data.aws_availability_zones.available.names,
    0,
    2
  )

  public_subnets = {
    "public-a" = {
      cidr = "10.20.1.0/24"
      az   = local.availability_zones[0]
    }
    "public-b" = {
      cidr = "10.20.2.0/24"
      az   = local.availability_zones[1]
    }
  }

  private_app_subnets = {
    "app-a" = {
      cidr = "10.20.11.0/24"
      az   = local.availability_zones[0]
    }
    "app-b" = {
      cidr = "10.20.12.0/24"
      az   = local.availability_zones[1]
    }
  }

  private_db_subnets = {
    "db-a" = {
      cidr = "10.20.21.0/24"
      az   = local.availability_zones[0]
    }
    "db-b" = {
      cidr = "10.20.22.0/24"
      az   = local.availability_zones[1]
    }
  }
}

resource "aws_vpc" "main" {
  cidr_block           = "10.20.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "${var.project_name}-vpc"
  }
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.project_name}-igw"
  }
}

resource "aws_subnet" "public" {
  for_each = local.public_subnets

  vpc_id                  = aws_vpc.main.id
  cidr_block              = each.value.cidr
  availability_zone       = each.value.az
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.project_name}-${each.key}"
    Tier = "Public"
  }
}

resource "aws_subnet" "private_app" {
  for_each = local.private_app_subnets

  vpc_id            = aws_vpc.main.id
  cidr_block        = each.value.cidr
  availability_zone = each.value.az

  tags = {
    Name = "${var.project_name}-${each.key}"
    Tier = "Private-App"
  }
}

resource "aws_subnet" "private_db" {
  for_each = local.private_db_subnets

  vpc_id            = aws_vpc.main.id
  cidr_block        = each.value.cidr
  availability_zone = each.value.az

  tags = {
    Name = "${var.project_name}-${each.key}"
    Tier = "Private-Database"
  }
}
