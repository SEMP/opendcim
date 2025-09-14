#!/bin/bash

# OpenDCIM Demo Data Population Script
# Populates OpenDCIM with realistic AI data center demo data

set -e

echo "🚀 Starting OpenDCIM AI Data Center Demo Population..."

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Change to the script directory (where docker-compose.yaml is located)
cd "$SCRIPT_DIR"

echo "📁 Working directory: $SCRIPT_DIR"

# Check if containers are running
if ! docker compose ps | grep -q "dcim-db.*Up"; then
    echo "❌ Error: dcim-db container is not running. Please start with 'docker compose up -d'"
    exit 1
fi

if ! docker compose ps | grep -q "dcim-web.*Up"; then
    echo "❌ Error: dcim-web container is not running. Please start with 'docker compose up -d'"
    exit 1
fi

echo "✅ Containers are running"

# Wait for database to be ready
echo "⏳ Waiting for database to be ready..."
sleep 5

# Execute the SQL script
echo "📊 Populating OpenDCIM with AI Data Center demo data..."
docker compose exec -T dcim-db mysql -u dcim -pdcim_user_secure_2024 dcim < final_demo_data.sql

if [ $? -eq 0 ]; then
    echo "✅ Demo data population completed successfully!"
    echo ""
    echo "📈 Your AI Data Center now includes:"
    echo "   • 1 Data Center: AI Research Center Madrid"
    echo "   • 9 Cabinets: Training, Inference, Storage, Network"
    echo "   • 18 GPU Servers: DGX A100 & H100 systems"
    echo "   • 5 Storage Arrays: High-performance NVMe"
    echo "   • Network Infrastructure: InfiniBand switches"
    echo "   • Management Servers: Kubernetes & Monitoring"
    echo "   • 4 Departments with assigned personnel"
    echo "   • Power distribution and environmental monitoring"
    echo ""
    echo "🌐 Access OpenDCIM at: http://localhost:8080"
    echo "🔧 Access phpMyAdmin at: http://localhost:8081"
    echo ""
    echo "📊 Key metrics you can now demonstrate:"
    echo "   • Device inventory and asset tracking"
    echo "   • Power consumption monitoring"
    echo "   • Space utilization (rack units)"
    echo "   • Equipment categorization with tags"
    echo "   • Environmental monitoring capabilities"
    echo "   • Virtualization tracking"
    echo ""
else
    echo "❌ Error occurred during data population"
    exit 1
fi

# Optional: Show summary statistics
echo "📋 Summary Statistics:"
docker compose exec dcim-db mysql -u dcim -pdcim_user_secure_2024 dcim -e "
SELECT
    'Data Centers' as Component, COUNT(*) as Count FROM fac_DataCenter
UNION ALL SELECT 'Cabinets', COUNT(*) FROM fac_Cabinet
UNION ALL SELECT 'Devices', COUNT(*) FROM fac_Device
UNION ALL SELECT 'Storage Arrays', COUNT(*) FROM fac_Device WHERE DeviceType='Storage Array'
UNION ALL SELECT 'GPU Servers', COUNT(*) FROM fac_Device WHERE Label LIKE 'AI-%'
UNION ALL SELECT 'Network Devices', COUNT(*) FROM fac_Device WHERE DeviceType='Switch'
UNION ALL SELECT 'Virtual Machines', COUNT(*) FROM fac_VMInventory;
"

echo ""
echo "🎯 Ready for academic demonstration and screenshots!"
echo "💡 Tip: Refresh the OpenDCIM dashboard to see the updated statistics"