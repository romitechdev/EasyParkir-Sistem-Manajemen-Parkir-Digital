# EasyParkir - Deployment dengan Cloudflare Tunnel

## Status Deployment ✅

Aplikasi EasyParkir telah berhasil di-deploy dengan Docker dan Cloudflare Tunnel.

### Kontainer yang Berjalan:
- **ep_db** (MySQL 5.7): Database server
- **ep_web** (PHP 8.1 Apache): Web application
- **ep_cloudflared** (Cloudflare Tunnel): Tunnel untuk public access

## Akses Aplikasi

### Via Cloudflare Tunnel (Public)
```
https://easyparkir.romitech.me
```

### Via Localhost (Local)
```
http://localhost:8000
```

### Direct Database Access
```
Host: localhost:3306
Username: parkiruser
Password: parkirpass
Database: parkir
```

## Database Information

### Tables
- `jenisKendaraan` - Vehicle types (3 records)
- `kendaraan_masuk` - Incoming vehicles
- `riwayat_keluar` - Exit history
- `slotParkir` - Parking slots
- `users` - User accounts (2 records)

### Default Users
- Username: admin
- Username: operator

## Docker Compose Services

```yaml
Services:
  - db: MySQL 5.7 database
  - web: PHP 8.1 Apache web server
  - cloudflared: Cloudflare Tunnel daemon
```

## Useful Commands

### View logs
```bash
docker-compose logs -f [service_name]
```

### Stop all services
```bash
docker-compose down
```

### Restart services
```bash
docker-compose up -d
```

### Database backup
```bash
docker exec ep_db mysqldump -u parkiruser -pparkirpass parkir > backup.sql
```

### Connect to MySQL
```bash
docker exec -it ep_db mysql -u parkiruser -pparkirpass parkir
```

## Architecture

```
┌─────────────────────────────────────────────┐
│   easyparkir.romitech.me (Cloudflare)       │
└────────────────────┬────────────────────────┘
                     │
                     ▼
            ┌────────────────────┐
            │  ep_cloudflared    │
            │  (Tunnel Daemon)   │
            └─────────┬──────────┘
                      │
                      ▼
            ┌────────────────────┐
            │   ep_web (port 80) │
            │  (PHP 8.1 Apache)  │
            └─────────┬──────────┘
                      │
                      ▼
            ┌────────────────────┐
            │  ep_db (port 3306) │
            │   (MySQL 5.7)      │
            └────────────────────┘
```

## Network Configuration

- **Network Name**: easyparkir-network
- **db Service**: Accessible from web as `db:3306`
- **web Service**: Maps port 8000 (localhost) → 80 (container)
- **cloudflared**: Routes traffic via Cloudflare tunnel

## Environment Variables

Web container environment:
```
DB_HOST=db
DB_USER=parkiruser
DB_PASS=parkirpass
DB_NAME=parkir
DB_PORT=3306
```

## Notes

- Cloudflare Tunnel is automatically configured with token
- Database is automatically initialized on first run
- All containers restart automatically if they fail
- Volumes are persisted in Docker for data consistency
