# 02 — Docker Setup Deep Dive for Jenkins CI/CD

This document explains how Docker integrates with Jenkins, why the Docker socket must be mounted, how Jenkins builds images, and how to validate that Docker is working correctly.

It is designed to help you understand **exactly how Docker interacts with Jenkins** in your CI pipeline.

---

# **1. Why Docker Is Critical for CI/CD**

Docker allows CI systems (like Jenkins) to:

- Build container images from your code  
- Run tests in isolated, reproducible environments  
- Package applications into portable artifacts  
- Push images to registries (ECR, Docker Hub, etc.)  
- Deploy to Kubernetes clusters (EKS)

Jenkins alone **cannot** build Docker images — it needs access to a Docker **daemon**.

On EC2, Docker runs **on the host**, and Jenkins communicates with it through:

