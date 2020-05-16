variable "private_ip" {}

variable "project" {
  description = "Project name"
  type        = string
  default     = "laravel-tweet-ddd"
}

variable "region" {
  description = "Default region"
  type        = string
  default     = "ap-northeast-1"
}

variable "default_route" {
  description = "Default route"
  type        = string
  default     = "0.0.0.0/0"
}

variable "domain" {
  description = "Domain name maneged in Route53."
  type        = string
  default     = "laravel-tweet-ddd.work"
}
