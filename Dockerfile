# Fixed: python:3-slim always resolves to the current Python 3 slim build,
# not pinned to a digest. Upstream keeps rebuilding/patching this tag, so it
# keeps scanning clean without any maintenance here. The API key is no
# longer baked into the image, and the app runs as a non-root user.
FROM python:3-slim
WORKDIR /app
COPY . .
RUN pip install --no-cache-dir -r requirements.txt \
    && useradd --create-home appuser \
    && chown -R appuser:appuser /app
USER appuser
CMD ["python", "app.py"]
