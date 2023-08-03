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

resource "local_file" "cf-details" {
  count = var.cloudflare_tunnel_run_local ? 1 : 0
  content = templatefile("${path.module}/cf.json.tpl",
    {
       account_tag = var.cloudflare_account_id
       tunnel_id   = cloudflare_tunnel.auto_tunnel.id
       tunnel_secret = random_id.tunnel_secret.b64_std
    }
  )
  filename = "${path.module}/cf.json"

}

resource "local_file" "cf-config" {
  count = var.cloudflare_tunnel_run_local ? 1 : 0
  content = templatefile("${path.module}/config.yaml.tpl",
    {
       tunnel_id   = cloudflare_tunnel.auto_tunnel.id,
       creds_path  = path.module
    }
  )
  filename = "${path.module}/config.yaml"
  depends_on = [ local_file.cf-details ]
}



resource "null_resource" "cf-runtime" {
  count = var.cloudflare_tunnel_run_local ? 1 : 0
  provisioner "local-exec" {
    command = "wget -nc -q -P ${path.module} https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64.deb && sudo dpkg -i ${path.module}/cloudflared-linux-amd64.deb"
  }

  provisioner "local-exec" {
    command = "cloudflared tunnel --config ${path.module}/config.yaml run "
  }
  depends_on = [ local_file.cf-config, local_file.cf-details ]
}