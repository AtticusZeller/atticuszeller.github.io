# Steps

## Server

### VPS

> A well-known cloud service provider is needed as the proxy server entry point. Here we use [DigitalOcean | Cloud Infrastructure for Developers](https://www.digitalocean.com/)

#### Machine

> Using `143.198.152.32` as example Machine IP

1. Choose San Francisco data center as it's closest to China, affecting network speed
2. Select the popular `Ubuntu` series, defaulting to `LTS` (Long Term Support) version
3. Ensure correct `SSH Key` is added

#### Payment

DigitalOcean accepts PayPal, with minimum monthly costs of $4-6

#### Security

Fail2ban automatically blocks IPs that frequently fail brute force attempts

```bash
sudo apt-get update
sudo apt-get install fail2ban
```

```bash
sudo systemctl start fail2ban
sudo systemctl enable fail2ban
```

Firewall

Start service:

```bash
sudo ufw enable
```

Check allowed/rejected ports:

```bash
sudo ufw status
```

Open required ports:

1. Client ports
2. Web panel ports
3. Default ports (`80`, `22`, etc.)

```bash
sudo ufw allow <port>
```

#### DNS

> `atticuszhou.xyz` as example domain

Set local DNS server using Cloudflare's Family Protection version to block malware and adult content.

Configuration:

```bash
# 1. Configure systemd-resolved with both IPv4 and IPv6 Family Protection DNS
sudo echo "[Resolve]
DNS=1.1.1.3 1.0.0.3 2606:4700:4700::1113 2606:4700:4700::1003
DNSStubListener=no
FallbackDNS=1.0.0.3 2606:4700:4700::1003
DNSSEC=true" | sudo tee /etc/systemd/resolved.conf

# 2. Set direct DNS resolution with both IPv4 and IPv6
sudo rm /etc/resolv.conf
sudo echo "nameserver 1.1.1.3
nameserver 1.0.0.3
nameserver 2606:4700:4700::1113
nameserver 2606:4700:4700::1003" | sudo tee /etc/resolv.conf

# 3. Restart systemd-resolved service
sudo systemctl restart systemd-resolved
```

Testing:

```bash
# Test IPv4 and IPv6 DNS resolution
nslookup -type=a google.com    # IPv4
nslookup -type=aaaa google.com # IPv6

# Test block
nslookup pornhub.com    # IPv4

# Check current DNS configuration
resolvectl status
```

> [!INFO] Add DNS Record:
> 1. Select the most popular domain provider [GoDaddy](https://account.godaddy.com/products)
> 2. Purchase domain (consider both initial and renewal prices)
> 3. Add DNS record: ensure t only one `A` type record resolves to your IP
>    - Type: `A`
>    - Name: `@`
>    - Value: `atticuszhou.xyz`
>    - TTL: `600` (or default)
>  4. Verify DNS resolution
> 	 1. [Worldwide DNS servers](https://www.whatsmydns.net/)
> 	 2. Test on local machines
> 		 ```bash
> 		 dig atticuszhou.xyz
> 		 ```
> 	3. Expected output
> 		```bash
> 		….omitted
> 		;; ANSWER SECTION:
> 		atticuszhou.xyz.	39	IN	A	143.198.152.32
> 		….omitted
> 		```

#### Install Certificate

> [!WARNING] Ensure DNS record has been resolved successfully before proceeding

```bash
sudo apt-get update
sudo apt-get install certbot -y
```

Fetch certificate:

```bash
sudo certbot certonly --standalone --agree-tos -d atticuszhou.xyz --email zhouge1831@gmail.com
certbot renew --dry-run
```

Verify auto-renewal service:

```bash
systemctl list-timers | grep certbot
```

Backup certificates if needed:

```
cp /etc/letsencrypt/live/atticuszhou.xyz/fullchain.pem /root/cert/
cp /etc/letsencrypt/live/atticuszhou.xyz/privkey.pem /root/cert/
```

Set appropriate permissions:

```bash
sudo chmod -R 644 /etc/letsencrypt/live/
sudo chmod -R 644 /etc/letsencrypt/archive/
```

#### Proxy Web Panel

[3x-ui: Xray panel supporting multi-protocol multi-user features](https://github.com/MHSanaei/3x-ui)

Installation:
CLI Options:
1. Configure web panel ports
2. View settings and login
3. Restore from `x-ui.db`
4. Review settings and re-login

```bash
x-ui
```

Panel Configuration:
1. Inbound Settings
	- Add inbound with Protocol `vless`
	- Set Transmission to `TCP` for stability
	- Configure Security with `TLS` using Digital Certificate
	- Enable Sniffing
	- Export All URLs to [subconverter](https://v1.v2rayse.com/v2ray-clash/)
2. Telegram Bot Setup
	- Create Bot following panel instructions
	- Enable _Database Backup_
	- Enable Login Notifications
3. Enable `Https` with `Public Key Path` and `Private Key Path` in Panel Settings
4. Xray Configuration
	- Enable `Family Protection` in Protection Shield
	- Enable WARP for chatgpt

## Client Side

[Proxy Software List](https://www.clashverge.dev/friendship.html)

### Connection Testing

Verify proxy server connectivity by checking:

1. Server IP accessibility - Try accessing server panel from local network
2. Port availability - Confirm ports are opened via `sudo ufw allow <port>`
3. Domain DNS resolution
	- Verify using [DNS checker](https://www.whatsmydns.net/)
4. Test speed directly in proxy software subscription nodes

### Proxy Clients

#### Desktop

[Clash Verge](https://www.clashverge.dev/) - GUI interface built on clash-Meta core for configuration management

#### Mobile

[FlClash](https://github.com/chen08209/FlClash) - Cross-platform client based on clash-Meta, written in Dart

#### Core Technology

[clash meta](https://wiki.metacubex.one/config/) - Leading proxy core running on user devices, handling traffic forwarding based on configuration rules
