#!/bin/bash

# Start script for Railway deployment
echo "Starting BIN Bimbel Backend..."

# Install Python dependencies
pip install -r backend/requirements.txt

# Start backend server
cd backend
uvicorn server:app --host 0.0.0.0 --port ${PORT:-8001}
