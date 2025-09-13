#!/bin/bash

# Fix PHP 8.2 compatibility issues in OpenDCIM index.php
# Replace null coalescing for number_format() calls to prevent deprecation warnings

sed -i 's/number_format($row\[\x27Devices\x27\])/number_format($row[\x27Devices\x27] ?? 0)/g' /var/www/html/index.php
sed -i 's/number_format($row\[\x27Servers\x27\])/number_format($row[\x27Servers\x27] ?? 0)/g' /var/www/html/index.php
sed -i 's/number_format($row\[\x27Size\x27\])/number_format($row[\x27Size\x27] ?? 0)/g' /var/www/html/index.php
sed -i 's/number_format($row\[\x27VMcount\x27\])/number_format($row[\x27VMcount\x27] ?? 0)/g' /var/www/html/index.php
sed -i 's/number_format($row\[\x22VMhosts\x22\])/number_format($row[\x22VMhosts\x22] ?? 0)/g' /var/www/html/index.php
sed -i 's/number_format($row\[\x22CabinetCount\x22\])/number_format($row[\x22CabinetCount\x22] ?? 0)/g' /var/www/html/index.php
sed -i 's/number_format($row\[\x27Power\x27\] \/ 1000)/number_format(($row[\x27Power\x27] ?? 0) \/ 1000)/g' /var/www/html/index.php

echo "PHP 8.2 compatibility fixes applied to index.php"