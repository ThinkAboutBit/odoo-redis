# Odoo with Redis library pre-installed
ARG ODOO_VERSION=19.0
FROM odoo:${ODOO_VERSION}

USER root

# Install redis Python library via apt (more reliable)
RUN apt-get update && \
    apt-get install -y --no-install-recommends python3-redis && \
    rm -rf /var/lib/apt/lists/*

USER odoo
