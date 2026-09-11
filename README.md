# Security Gatekeeper Demo

Demonstrates a GitHub Actions pipeline that builds a Docker image, scans it
with [Trivy](https://github.com/aquasecurity/trivy), and only pushes to Azure
Container Registry if no CRITICAL (fixable) vulnerabilities are found.

## Branches

- `vulnerable` — `Dockerfile` is pinned **by digest** to a `debian:bullseye`
  build from 2021. That digest is immutable, so Trivy will always find the
  same 17 CRITICAL, fixable CVEs — the scan step fails and the push step is
  skipped.
- `main` — `Dockerfile` uses the `debian:stable-slim` tag (not pinned), which
  always resolves to whichever Debian release is current stable (Trixie as of
  writing). Debian keeps rebuilding/patching this tag, so it keeps scanning
  clean without any maintenance here — even as "stable" itself moves on to
  future releases — and the push step runs.

This split is designed to need zero upkeep: the vulnerable side is frozen in
time by digest, and the fixed side rides upstream's own patch cadence. Both
were verified locally with `trivy image --severity CRITICAL --ignore-unfixed`.

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
