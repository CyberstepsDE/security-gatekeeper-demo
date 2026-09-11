# Security Gatekeeper Demo

Demonstrates a GitHub Actions pipeline that builds a Docker image, scans it
with [Trivy](https://github.com/aquasecurity/trivy), and only pushes to Azure
Container Registry if no CRITICAL (fixable) vulnerabilities are found.

## Branches

- `vulnerable` — `Dockerfile` is pinned (by digest) to `node:18.0.0`, which
  Trivy consistently flags with a CRITICAL, fixed vulnerability. The push
  step is skipped because the scan step fails first.
- `main` — `Dockerfile` is pinned to `node:22-alpine`, a currently clean base
  image. The scan passes and the push step runs.

Both Dockerfiles reference base images by **immutable digest** (not a
floating tag), so the scan results are reproducible indefinitely — the
"vulnerable" branch will keep finding the same CVE and the "main" branch will
keep passing, regardless of when the demo is run.

## Required repo secrets

Set these before the push step will work against a real registry:

- `ACR_LOGIN_SERVER`
- `ACR_USERNAME`
- `ACR_PASSWORD`
