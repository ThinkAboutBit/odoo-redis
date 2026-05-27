# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2026-05-27

### Added
- Initial release - tested and verified on Odoo 16.0, 17.0, 18.0, and 19.0
- **Master-Replica Sidecar Pattern** - Dual connection architecture for optimal performance
- **Ultra-fast localhost reads** (~0.1ms) via local Redis sidecar
- **Automatic fallback** to Master on local replica miss
- **Single Redis Mode** - Works without sidecar for simpler deployments
- **Password authentication** support for both Master and Local connections
- **Separate TTL** for authenticated (7 days) and anonymous (3 hours) sessions
- **Kubernetes deployment examples** with sidecar containers
- **Docker Compose examples** for local development and testing
- Comprehensive documentation and architecture diagrams

### Technical Details
- Compatible with Odoo 16.0, 17.0, 18.0, and 19.0
- Requires Python `redis` library (>= 4.0)
- Configurable via environment variables
- Monkey-patches `odoo.http.Root.session_store`
- Session data serialized with `pickle` for full Python object support

## Roadmap

### [1.1.0] - Planned
- Redis Sentinel support for Master failover
- Connection pooling for better resource management
- Prometheus metrics endpoint

### [1.2.0] - Planned
- Redis Cluster support (multiple shards)
- Configuration via odoo.conf (in addition to env vars)
- Session migration utility from filesystem

---

## Version Numbering

This module uses semantic versioning:

`{major}.{minor}.{patch}`

- **1** - Major version (breaking changes)
- **0** - Minor version (new features)
- **0** - Patch version (bug fixes)

This format works across all Odoo versions (16.0, 17.0, 18.0, 19.0).
