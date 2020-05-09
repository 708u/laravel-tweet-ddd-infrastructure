variable "project" {
  default = "Laravel-tweet-ddd"
}

variable "region" {
  default = "ap-northeast-1"
}

variable "default_route" {
  default = "0.0.0.0/0"
}

variable "domain" {
  description = "Domain name maneged in Route53."
  type        = string
  default     = "laravel-tweet-ddd.work"
}
