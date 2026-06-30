FROM mirror.gcr.io/library/node:22-alpine AS builder
# build-time env seeded from .env.example
ENV EXPO_PUBLIC_APPLE_MAPKIT_JS_KEY=xxx
ENV EXPO_UNSTABLE_DEPLOY_SERVER=1
ENV GOOGLE_MAPS_API_KEY=xxx
ENV OPENAI_API_KEY=sk-xxx
ENV TMDB_API_KEY=xxx
ENV TMDB_READ_ACCESS_TOKEN=xxx
ENV WEATHER_API_KEY=xxx
WORKDIR /app
COPY . .
RUN yarn install --frozen-lockfile --production

FROM mirror.gcr.io/library/node:22-alpine
WORKDIR /app
COPY --from=builder /app ./
ENV NODE_ENV=production
EXPOSE 8081
CMD ["yarn", "start"]
