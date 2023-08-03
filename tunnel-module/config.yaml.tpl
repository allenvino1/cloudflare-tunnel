# Name of the tunnel you want to run
tunnel: "${tunnel_id}"
# The location of the secret containing the tunnel credentials
credentials-file: ${creds_path}/cf.json
# General purpose TCP routing for the network
warp-routing:
  enabled: true
ingress:
  # This rule matches any traffic which didn't match a previous rule, and responds with HTTP 404.
  - service: http_status:404
