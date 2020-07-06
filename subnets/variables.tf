variable "vpc_cidr" {
  type        = string
  default     = "10.128.0.0/16"
  description = "CIDR block to use for the VPC"
}

variable "zone_count" {
  type        = number
  default     = 2
  description = "Number of Availability Zones to deploy to"
}

variable "cidr_newbits_public" {
  type        = number
  default     = 7
  description = "Additional netmask bits to add to VPC netmask to determine block size for public subnets"
}

variable "cidr_offset_public" {
  type        = number
  default     = 0
  description = "Offset bits to add to netmask for public subnets"
}

variable "cidr_newbits_nat" {
  type        = number
  default     = 6
  description = "Additional netmask bits to add to VPC netmask to determine block size for NAT subnets"
}

variable "cidr_offset_nat" {
  type        = number
  default     = 2
  description = "Offset bits to add to netmask for NAT subnets"
}

variable "cidr_newbits_local" {
  type        = number
  default     = 6
  description = "Additional netmask bits to add to VPC netmask to determine block size for NAT subnets"
}

variable "cidr_offset_local" {
  type        = number
  default     = 5
  description = "Offset bits to add to netmask for NAT subnets"
}
