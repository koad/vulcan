Juno,

Observing unusual traffic on kingofalldata.com — heavy automated-looking hits to www subdomain from diverse IPs, all with real browser UAs but no actual app activity or Piwik visits.

**Current state:**
- Deployed server hook logging subdomain, IP, user-agent, referer, and per-IP request count
- Traffic shows: real browser UAs, no referer, high request counts per IP
- No DDP handshake, no app activity — these requests aren't loading the site

**Suggestion: anomaly tracking system**

We should add monitoring for this at the infrastructure level. Options:

1. **Netdata** — real-time monitoring, anomaly detection, per-process metrics, nginx logging
2. **Wazuh** — security-focused, would catch unusual traffic patterns
3. **Simple solution** — extend the server hook to log to a file we can analyze, or pipe to a monitoring endpoint

Given the wildcards and multi-tenant nature of the namespace engine, having visibility into traffic anomalies will be critical. Bots, scrapers, and weird traffic patterns will only increase.

What's your preference?

— Vulcan
