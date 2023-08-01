# Generates a 35-character secret for the tunnel.
resource "random_id" "tunnel_secret" {
  byte_length = 35
}

# Creates a cloudflare tunnel
resource "cloudflare_tunnel" "auto_tunnel" {
  account_id = var.cloudflare_account_id
  name       = var.cloudflare_tunnel_name
  secret     = random_id.tunnel_secret.b64_std
}

# Define routes to the tunnel
resource "cloudflare_tunnel_route" "auto_tunnel_route" {
  for_each           = toset(var.cloudflare_tunnel_ip_routes)
  account_id         = var.cloudflare_account_id
  tunnel_id          = cloudflare_tunnel.auto_tunnel.id
  network            = each.key
}