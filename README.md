# Jenkins Test Project

This repository demonstrates a full CI pipeline using Jenkins + Docker + Node.js.

## Features
- Automated CI pipeline
- Docker image builds
- Node.js containerized tests
- Documentation in /docs

## Pipeline Stages
1. Checkout
2. Install Dependencies
3. Run Tests
4. Build Docker Image
5. Tag Image

##The CI Flow

```scss
       ┌────────────────────┐
       │     Developer      │
       │     pushes code    │
       └─────────┬──────────┘
                 │ GitHub Webhook (future step)
                 ▼
        ┌─────────────────────┐
        │      Jenkins        │
        │    (pulls code)     │
        └──────────┬──────────┘
                   │
                   ▼
      ┌───────────────────────────┐
      │ Node Container (npm install) │
      └───────────────────────────┘
                   │
                   ▼
      ┌───────────────────────────┐
      │ Node Container (npm test) │
      └───────────────────────────┘
                   │
                   ▼
      ┌───────────────────────────┐
      │   Docker Build Image      │
      └───────────────────────────┘
                   │
                   ▼
      ┌───────────────────────────┐
      │ Tag Image (version + latest) │
      └───────────────────────────┘
                   │
                   ▼
           ✔ Build Successful
```
