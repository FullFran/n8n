# 🧠 n8n Professional Deployment Template (Self-Hosted, Community Edition)

This repository contains a production-ready template for deploying [n8n](https://n8n.io) — the powerful workflow automation tool — in a secure, scalable, and extensible environment without the need for the Enterprise license.

It supports:
- Scalable worker-based execution using Redis queues
- Secure PostgreSQL storage
- Automated backups
- Clean environment separation (production, staging, internal)
- Optional domain-based configuration with HTTPS
- Full customization for real-world, team-based use cases

---

## 🚀 What's Included

### ✅ Production-Grade Services

- `n8n`: Main web interface, configured securely with basic authentication and HTTPS support.
- `n8n-worker`: Headless execution container using `EXECUTIONS_MODE=queue`.
- `redis`: Used for queue-based execution management.
- `postgres`: Stores workflows, credentials, and execution logs.
- `volumes`: Persistent storage for DB and n8n internal data.

### ✅ Smart Environment Inheritance

The deployment uses an `x-shared` block in `docker-compose.yml` to:
- Avoid duplication across services
- Ensure consistent environment variables
- Keep the configuration DRY and clean

---

## 📁 Folder Structure

```
├── docker-compose.yml         # Main multi-service deployment
├── .env                       # Environment variables (not committed)
├── .env.production.example    # Example file for secure deployments
├── scripts/
│   └── backup.sh              # Optional: cron-compatible backup script
└── README.md                  # You're here!
```

---

## 🧪 How to Use

### 1. Clone the Repository

```bash
git clone https://github.com/your-org/n8n-deploy-template.git
cd n8n-deploy-template
```

### 2. Create Your `.env` File

```bash
cp .env.production.example .env
```

Edit the file and fill in secure values for your database, domain, and encryption key.

> The deployment will default to `localhost` if `N8N_DOMAIN` is not provided.

### 3. Launch the Stack

```bash
docker compose up -d
```

---

## 🌐 Optional Domain Support

You can configure your deployment for a custom domain:

```env
N8N_DOMAIN=n8n.yourdomain.com
N8N_PROTOCOL=https
```

If these values are omitted, the system will default to `localhost` for development.

---

## ⚙️ Add More Workers

You can scale execution by adding more `n8n-worker` services:

```yaml
n8n-worker-2:
  <<: *shared
  command: worker

n8n-worker-3:
  <<: *shared
  command: worker
```

Workers will auto-discover tasks via Redis queues and run them in parallel.

---

## 🔐 Security Highlights

- 🔑 `ENCRYPTION_KEY` for data protection (required in production)
- 🔐 Basic auth enabled by default
- 🔒 No ports exposed publicly except for `n8n`
- 🧱 Optional reverse proxy support (e.g., Traefik, Nginx)
- 🌩️ Cloudflare integration recommended for production

---

## 🧼 Backup Support

Backups can be made using a simple cron-compatible script like this:

```bash
docker exec n8n tar czf /backups/n8n-$(date +%F).tar.gz /home/node/.n8n
```

You can also export workflows and credentials directly via n8n and upload them to S3, email, or another backup destination.

---

## 📈 Observability (Optional)

- 🔍 Logs available via `docker logs n8n`
- 🧭 Integrate Prometheus + Grafana + Loki for metrics and logging
- Monitor queue execution, failed jobs, execution time, etc.

---

## 💡 Tips

- Each environment (production, test, internal) can use its own `.env` file and DB instance.
- You can customize the n8n UI by injecting branding via Dockerfile overrides (optional).
- A GitHub Actions workflow can automate deployment to platforms like Dokploy or Railway.

---

## 🧪 Example `.env.production.example`

```env
ENCRYPTION_KEY=REPLACE_WITH_SECURE_KEY
N8N_BASIC_AUTH_ACTIVE=true
N8N_BASIC_AUTH_USER=admin
N8N_BASIC_AUTH_PASSWORD=REPLACE_WITH_SECURE_PASSWORD

POSTGRES_USER=n8n
POSTGRES_PASSWORD=REPLACE_WITH_SECURE_DB_PASSWORD
POSTGRES_DB=n8n

N8N_DOMAIN=n8n.example.com
N8N_PROTOCOL=https
```

---

## 📎 License

MIT or custom license depending on your organization needs.

---

## ✍️ Credits

Template created and maintained by [Franblakia](https://github.com/franblakia) for BlakIA.

Powered by [n8n](https://n8n.io), PostgreSQL, Redis and Docker Compose.
