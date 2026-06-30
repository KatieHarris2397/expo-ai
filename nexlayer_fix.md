# Nexlayer working build fix

This file is the authoritative, pinned build solution for this repo. Nexlayer uses it verbatim on every run and will not override it. If a future build with this fix fails, Nexlayer appends/updates it rather than regenerating.

## Fixed Dockerfile

```dockerfile
FROM mirror.gcr.io/library/node:22-alpine AS builder
WORKDIR /app

# Install build dependencies for native modules
RUN apk add --no-cache python3 make g++ linux-headers

# Copy lockfiles first for better caching
COPY package.json yarn.lock ./

# Install all dependencies (including devDeps for building)
RUN yarn install --frozen-lockfile

# Copy the rest of the source code
COPY . .

# Operator Fix: Ensure typescript is installed to satisfy Expo build requirements
RUN npx expo install typescript@~5.9.2

# Build for web
RUN npx expo export -p web

FROM mirror.gcr.io/library/node:22-alpine
WORKDIR /app

# Install a static server to serve the expo export output
RUN npm install -g serve

# Copy the static output from the builder
COPY --from=builder /app/dist ./dist

ENV NODE_ENV=production
ENV PORT=8081
ENV HOSTNAME=0.0.0.0

EXPOSE 8081
CMD ["serve", "-s", "dist", "-l", "8081"]
```
