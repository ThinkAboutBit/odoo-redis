{
    "name": "Redis Session Store - Sidecar Pattern",
    "summary": "10x faster session reads with Master-Replica sidecar architecture for Kubernetes",
    "description": "
Redis Session Store with Sidecar Pattern
=========================================

**The fastest Redis session store for Odoo.** Designed for high-traffic 
Kubernetes deployments with 1M+ concurrent users.

Why This Module?
----------------
Traditional Redis session modules connect to a single Redis endpoint. 
Every page request requires a network round-trip (~1ms) to read the session.
At scale, this becomes a bottleneck.

This module implements the **Master-Replica Sidecar pattern**:

* **WRITES** → Redis Master (network, ~1ms) - source of truth
* **READS** → Local Replica (localhost, ~0.1ms) - 10x faster
* **FALLBACK** → Master if local miss - handles replication lag

Performance Comparison
----------------------
+-------------+-------------------+-------------------+
| Operation   | Other Modules     | This Module       |
+=============+===================+===================+
| Read        | ~1ms (network)    | ~0.1ms (localhost)|
| Write       | ~1ms (network)    | ~1ms (network)    |
+-------------+-------------------+-------------------+

**Result: 90% reduction in session read latency**

Key Features
------------
* ⚡ **10x Faster Reads** - Localhost access instead of network calls
* ☸️ **Kubernetes Native** - Built for sidecar container pattern
* 🔄 **Auto Fallback** - Handles replication lag gracefully  
* 🔀 **No Sticky Sessions** - Works with any load balancing algorithm
* 💪 **Fault Tolerant** - Pod failure doesn't lose sessions
* 🔧 **Flexible Deployment** - Sidecar mode OR single Redis mode
* 🔐 **Secure** - Password authentication for Master and Replica
* ⏰ **Smart TTL** - Different expiry for authenticated vs anonymous

Perfect For
-----------
* High-traffic e-commerce (1M+ users)
* Kubernetes/GKE/EKS deployments
* Multi-pod Odoo clusters
* Zero-downtime deployments

Configuration
-------------
Simple environment variable configuration:

* ``REDIS_MASTER_HOST``: Master hostname (default: redis-master)
* ``REDIS_MASTER_PORT``: Master port (default: 6379)
* ``REDIS_LOCAL_HOST``: Local replica hostname (default: localhost)
* ``REDIS_LOCAL_PORT``: Local replica port (default: 6379)
* ``SESSION_EXPIRY``: Session TTL in seconds (default: 7 days)

Usage
-----
Add to server_wide_modules in odoo.conf::

    server_wide_modules = base,web,session_redis_sidecar

Support
-------
* Documentation: Full README with Kubernetes deployment examples
* Examples: Docker Compose setup included for local testing
* Source: unoffocialtab@gmail.com",
    "version": "19.0.1.0.0",
    "category": "Technical",
    "author": "Think About Bit Technologies",
    "website": "www.thinkaboutbit.com",
    "license": "LGPL-3",
    "price": 210.00,
    "currancy": 'EUR',
    "depends": ["base"],
    "external_dependencies": {
        "python": ["redis"],
    },
    "images": [
        "static/description/icon.png",
    ],
    "data": [],
    "installable": True,
    "auto_install": False,
    "application": False,
}
