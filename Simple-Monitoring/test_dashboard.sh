#!/bin/bash

echo "Starting CPU load..."
yes > /dev/null &
CPU_PID=$!

echo "Starting disk activity..."
dd if=/dev/zero of=/tmp/netdata-test-file bs=1M count=500 status=progress

echo "Starting memory load..."
python3 -c "
data = []
for _ in range(300):
    data.append('x' * 1024 * 1024)
import time
time.sleep(30)
" &

echo "Testing for 30 seconds..."
sleep 30

kill "$CPU_PID"
rm -f /tmp/netdata-test-file

echo "Test finished. Check the Netdata dashboard."