#!/bin/bash
set -e
set -x

wget -O measurements_MS.tar.gz 'https://gitlab.com/ska-telescope/src/src-api/ska-src-api-global-execution/-/raw/sp-6376/etc/fits/measurements_MS.tar.gz?ref_type=heads&inline=false'
echo "=== DOWNLOADED TAR ==="
ls -l measurements_MS.tar.gz

echo "=== INSIDE CONTAINER ==="
pwd
ls -lh

echo "Extracting Measurement Set..."
tar -xzf measurements_MS.tar.gz

echo "Contents after extract:"
ls -lh
ls -lh measurements.MS

echo "WSClean version:"
wsclean --version

echo "Running WSClean imaging..."
wsclean \
  -name test_image \
  -size 256 256 \
  -scale 10asec \
  measurements.MS

echo "=== DONE ==="
