

module "cloudflare_tunnel" {
    source = "./tunnel-module"
    cloudflare_account_id = "0037d3813940dbb5b7d4f061a8046776"
    cloudflare_tunnel_name = "rnd-tunnel"
    cloudflare_tunnel_ip_routes = ["172.29.207.0/20"]
}