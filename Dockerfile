# Fixed: current debian:bookworm-slim (a maintained, regularly rebuilt tag).
# Unlike the vulnerable branch, this is deliberately NOT pinned to a digest —
# upstream keeps patching this tag, so it keeps scanning clean without any
# maintenance on our side.
FROM debian:bookworm-slim
WORKDIR /app
COPY index.html .
CMD ["cat", "index.html"]
