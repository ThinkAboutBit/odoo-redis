#!/bin/bash
# =============================================================================
# Test Script for Odoo Redis Session Sidecar
# =============================================================================

set -e

echo "=========================================="
echo "  Odoo Redis Session Sidecar - Test"
echo "=========================================="
echo ""

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Check prerequisites
echo "1. Checking prerequisites..."
if ! command -v docker &> /dev/null; then
    echo -e "${RED}Docker not found. Please install Docker.${NC}"
    exit 1
fi
echo -e "${GREEN}   ✓ Docker found${NC}"

# Start services
echo ""
echo "2. Starting services..."
docker compose up -d

echo ""
echo "3. Waiting for services to be healthy..."
sleep 10

# Check Redis Master
echo ""
echo "4. Checking Redis Master..."
if docker exec redis-master redis-cli ping | grep -q PONG; then
    echo -e "${GREEN}   ✓ Redis Master is running${NC}"
else
    echo -e "${RED}   ✗ Redis Master not responding${NC}"
    exit 1
fi

# Check replication
echo ""
echo "5. Checking Redis replication..."
REPLICAS=$(docker exec redis-master redis-cli info replication | grep connected_slaves | cut -d: -f2 | tr -d '\r')
echo "   Connected replicas: $REPLICAS"
if [ "$REPLICAS" -ge 1 ]; then
    echo -e "${GREEN}   ✓ Replicas connected${NC}"
else
    echo -e "${YELLOW}   ⚠ No replicas connected yet (may still be starting)${NC}"
fi

# Check Odoo pods
echo ""
echo "6. Checking Odoo pods..."
for pod in odoo-pod-1 odoo-pod-2; do
    if docker ps | grep -q $pod; then
        echo -e "${GREEN}   ✓ $pod is running${NC}"
    else
        echo -e "${RED}   ✗ $pod not running${NC}"
    fi
done

# Check sidecars
echo ""
echo "7. Checking Redis sidecars..."
for sidecar in redis-sidecar-1 redis-sidecar-2; do
    if docker ps | grep -q $sidecar; then
        echo -e "${GREEN}   ✓ $sidecar is running${NC}"
    else
        echo -e "${RED}   ✗ $sidecar not running${NC}"
    fi
done

# Test Odoo access
echo ""
echo "8. Testing Odoo HTTP access..."
sleep 5
if curl -s -o /dev/null -w "%{http_code}" http://localhost:8069/web/login | grep -q "200\|302"; then
    echo -e "${GREEN}   ✓ Odoo is accessible at http://localhost:8069${NC}"
else
    echo -e "${YELLOW}   ⚠ Odoo not ready yet. Wait a moment and try http://localhost:8069${NC}"
fi

# Check session module loaded
echo ""
echo "9. Checking session module in Odoo logs..."
sleep 2
if docker logs odoo-pod-1 2>&1 | grep -q "RedisSidecarSessionStore"; then
    echo -e "${GREEN}   ✓ Redis session module loaded in Pod 1${NC}"
else
    echo -e "${YELLOW}   ⚠ Check logs: docker logs odoo-pod-1${NC}"
fi

echo ""
echo "=========================================="
echo "  Test Complete!"
echo "=========================================="
echo ""
echo "Next steps:"
echo "  1. Open http://localhost:8069"
echo "  2. Create database and login"
echo "  3. Check sessions: docker exec redis-master redis-cli keys 'odoo_session:*'"
echo "  4. Test failover: docker stop odoo-pod-1"
echo "  5. Refresh browser - session should persist!"
echo ""
echo "Useful commands:"
echo "  - View logs: docker logs -f odoo-pod-1"
echo "  - Check replication: docker exec redis-master redis-cli info replication"
echo "  - List sessions: docker exec redis-master redis-cli keys 'odoo_session:*'"
echo "  - Stop: docker compose down"
echo ""
