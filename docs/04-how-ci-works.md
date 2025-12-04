# How CI Works in This Repo

Continuous Integration Pipeline:

1. Push code → GitHub
2. Jenkins pulls latest commit
3. Runs build steps inside containers
4. Produces a Docker image
5. Provides an artifact (container image)
6. Ready for deployment (ECR/EKS)

This repo demonstrates a full CI workflow using:
- Jenkins
- GitHub
- Node.js
- Docker
