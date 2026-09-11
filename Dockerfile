# Fixed: base image pinned (by digest) to a currently clean node:22-alpine.
# Pinning by digest keeps this reproducible forever — no drift from a
# floating tag getting rebuilt out from under the demo.
FROM node@sha256:c610fcdfb1d5b4740dd70c284ed3cb16bb857e0f7166196e36a5501df7a3aa32
WORKDIR /app
COPY package*.json ./
RUN npm install --omit=dev
COPY . .
CMD ["node", "index.js"]
