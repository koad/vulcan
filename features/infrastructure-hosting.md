# Infrastructure & Hosting

**Owner:** Vulcan  
**Status:** Active  
**Type:** Operations

## Description

Manage hosting infrastructure, nginx reverse proxy configuration, deployment pipelines, and DevOps work for koad:io entities and products.

## Inputs

- New vhost requirements
- Deployment specs
- Infrastructure decisions from leadership
- SSL certificate requests

## Outputs

- Nginx config deployed and live
- Docker containers (Alpine nginx, Meteor instances)
- Deployment automation
- Operational procedures

## Infrastructure Details

- **Primary:** dotsh (Vultr, Toronto) — active
- **Retiring:** 10.10.10.12 (Contabo, St. Louis) — don't build new things here
- **Pattern:** matrix-nginx-proxy (Alpine nginx in Docker)

## Active Work

- Nginx/Meteor DDP integration (vulcan#16)
- Rate limiting implementation
