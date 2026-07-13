# DNS Setup

## GitHub Pages

1. Added the custom domain in **GitHub → Settings → Pages**.
2. Added GitHub’s `A` records in the domain’s DNS settings.
3. Added a `CNAME` record for `www` pointing to the GitHub Pages address.
4. Enabled **Enforce HTTPS** after DNS propagation.
5. Opened the domain and confirmed the site was working.

## DigitalOcean Droplet

1. Copied the Droplet’s public IP address.
2. Added an `A` record pointing a subdomain to the Droplet IP.
3. Updated the Nginx `server_name` with the domain.
4. Tested and reloaded Nginx.
5. Opened the domain and confirmed the website was working.