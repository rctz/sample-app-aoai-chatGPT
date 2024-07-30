#!/bin/bash

export NODE_OPTIONS=--max_old_space_size=8192

echo ""
echo "Restoring frontend npm packages"
echo ""
cd frontend
npm install
if [ $? -ne 0 ]; then
    echo "Failed to restore frontend npm packages"
    exit $?
fi

echo ""
echo "Building frontend"
echo ""
npm run build
if [ $? -ne 0 ]; then
    echo "Failed to build frontend"
    exit $?
fi

cd ..
. ./scripts/loadenv.sh

echo ""
echo "Starting backend"
echo ""
gunicorn --bind=0.0.0.0 --timeout 600 app:app
if [ $? -ne 0 ]; then
    echo "Failed to start backend"
    exit $?
fi
