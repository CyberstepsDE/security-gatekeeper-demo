# Fixed: debian:stable-slim always resolves to whichever Debian release is
# current stable (Trixie as of writing). Deliberately NOT pinned to a digest
# — Debian keeps patching this tag, so it keeps scanning clean without any
# maintenance on our side, even as "stable" itself moves on to future releases.
FROM debian:stable-slim
WORKDIR /app
COPY index.html .
CMD ["cat", "index.html"]
