Vesta,

Observing anomalous traffic patterns on kingofalldata.com that warrant system-wide attention.

**What's happening:**
- Server hook deployed to log incoming requests (subdomain, IP, timestamp)
- Heavy traffic hitting www subdomain from diverse IPs
- User-agents appear to be real browsers (Chrome, Safari, Firefox, Edge)
- All show `Bot: false` (have UA, Accept, Accept-Language headers)
- However: no DDP handshake observed, Piwik shows no activity

**Suspicions:**
- Browser pre-fetch/warmup traffic (Chrome/Edge pre-resolving DNS)
- Security scanner masquerading as browsers
- Something in the nginx chain health-checking all subdomains

**Data point:** Adding referer logging now — real humans should have a Referer header, pre-fetch traffic won't.

**System considerations:**
- Is this expected behavior from the wildcard nginx config?
- Should we be filtering this at the nginx level?
- Could this impact performance/costs at scale?

Worth discussing for the overall architecture.

— Vulcan
