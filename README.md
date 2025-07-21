# Calculator Application

## Overview
This is a simple calculator application project built end-to-end demonstrating core programming concepts, DevOps pipelines, and deployment automation.

## Features
- Basic arithmetic operations: addition, subtraction, multiplication, division
- User-friendly interface (if applicable)
- Easily deployable with Kubernetes manifests and scripts
- CI/CD enabled (optional)

## Project Structure
- `app.py` - main application code
- `Dockerfile` - containerization setup
- `deployment.yaml` - Kubernetes deployment manifest
- `service.yaml` - Kubernetes service manifest
- `update-k8s.sh` - automation script to update Kubernetes cluster

## Prerequisites
- Python 3.x
- Docker
- Kubernetes cluster (e.g., AKS)
- kubectl CLI

## How to Run Locally
```bash
python app.py
