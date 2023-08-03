# Cloudflare variables
variable "cloudflare_tunnel_name" {
  description = "Name of the Cloudflare tunnel"
  type        = string
  sensitive   = true
  default     = "rnd-tunnel"
}

variable "cloudflare_account_id" {
  description = "Cloudflare account ID"
  type        = string
  sensitive   = true
  default     = "0037d3813940dbb5b7d4f061a8046776"
}

variable "cloudflare_tunnel_version" {
  description = "Version of the cloudflared application"
  type        = string
  default     = "2023.7.1"
}

variable "cloudflare_tunnel_ip_routes" {
  description = "IP routes of the VPC"
  type        = list
  default     = ["10.185.1.0/20"]
}

variable "cloudflare_tunnel_run_local" {
  description = "Flag to run the tunnel locally"
  type        = bool
  default     = false
}