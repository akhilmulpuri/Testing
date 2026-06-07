# modules/elb/main.tf
resource "aws_elb" "this" {
  name               = var.name
  availability_zones = var.availability_zones

  listener {
    instance_port     = var.instance_port
    instance_protocol = var.instance_protocol
    lb_port           = var.lb_port
    lb_protocol       = var.lb_protocol
  }

  health_check {
    target              = var.health_check_target
    interval            = var.health_check_interval
    timeout             = var.health_check_timeout
    healthy_threshold   = var.health_check_healthy
    unhealthy_threshold = var.health_check_unhealthy
  }

  security_groups = var.security_groups
  tags            = var.tags
}

# modules/elb/variables.tf
variable "name" {
  description = "Name of the ELB"
  type        = string
}

variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)
}

variable "instance_port" {
  description = "Port on the instance to route to"
  type        = number
}

variable "instance_protocol" {
  description = "Protocol for instance (HTTP, HTTPS, TCP)"
  type        = string
}

variable "lb_port" {
  description = "Port on the ELB"
  type        = number
}

variable "lb_protocol" {
  description = "Protocol for ELB (HTTP, HTTPS, TCP)"
  type        = string
}

variable "health_check_target" {
  description = "Target for health check (e.g., HTTP:80/)"
  type        = string
}

variable "health_check_interval" {
  description = "Interval between health checks"
  type        = number
  default     = 30
}

variable "health_check_timeout" {
  description = "Timeout for health check"
  type        = number
  default     = 5
}

variable "health_check_healthy" {
  description = "Healthy threshold"
  type        = number
  default     = 2
}

variable "health_check_unhealthy" {
  description = "Unhealthy threshold"
  type        = number
  default     = 2
}

variable "security_groups" {
  description = "Security groups for ELB"
  type        = list(string)
}

variable "tags" {
  description = "Tags for ELB"
  type        = map(string)
  default     = {}
}

# modules/elb/outputs.tf
output "elb_dns_name" {
  description = "DNS name of the ELB"
  value       = aws_elb.this.dns_name
}
