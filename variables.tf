variable "aws_region" {
  type        = string
  description = "AWS region"
  default     = "us-east-2"
}

variable "instance_type" {
  type        = string
  description = "EC2 instance type"
  default     = "t3.small"
}

variable "key_name" {
  type        = string
  description = "Existing EC2 key pair name"
  default     = "vehicle-api-key"
}