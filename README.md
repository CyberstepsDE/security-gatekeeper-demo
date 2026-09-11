# Security Gatekeeper Demo

Companion repo for the "Container Security & Delivery" session. Demonstrates
a GitHub Actions pipeline that builds a Docker image, scans it with
[Trivy](https://github.com/aquasecurity/trivy), and only pushes to Azure
Container Registry if no CRITICAL (fixable) vulnerabilities are found.

The app is the same minimal Flask app used in the slides' "Spot the
Problems" exercise, with the same problems intentionally present on the
`vulnerable` branch: old base image, a secret baked into the image, and the
container running as root.

## Branches

- `vulnerable` — `Dockerfile` is pinned **by digest** to `python:3.8-slim`
  (the exact tag used in the slides' scan demo). That digest is immutable,
  so Trivy will always find the same 4 CRITICAL, fixable CVEs — the scan
  step fails and the push step is skipped. The `API_KEY` secret is also
  baked into the image via `ENV`, and the container runs as `root`.
- `main` — `Dockerfile` uses the `python:3-slim` tag (not pinned), which
  always resolves to the current Python 3 slim build. Python keeps
  rebuilding/patching this tag, so it keeps scanning clean without any
  maintenance here. The secret is gone, and the app runs as a non-root user.

This split is designed to need zero upkeep: the vulnerable side is frozen in
time by digest, and the fixed side rides upstream's own patch cadence. Both
were verified locally:

```bash
trivy image --severity CRITICAL --ignore-unfixed <image>
```

## Required repo secrets

Set these before the "Push to ACR" step will work against a real registry:

- `ACR_LOGIN_SERVER`
- `ACR_USERNAME`
- `ACR_PASSWORD`

```bash
gh secret set ACR_LOGIN_SERVER --body "<registry>.azurecr.io"
gh secret set ACR_USERNAME --body "<username>"
gh secret set ACR_PASSWORD --body "<password>"
```
