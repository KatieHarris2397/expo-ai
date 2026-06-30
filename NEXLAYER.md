# Nexlayer — expo-ai

<!-- nexlayer:meta version=1 analyzed=2026-06-30T14:51:58Z repo=https://github.com/KatieHarris2397/expo-ai branch=main -->

> **For AI agents (Claude Code, Cursor, Gemini CLI, Copilot):**
> This file is the **project context** for this Nexlayer deployment — tech stack, env vars, secrets, live URL.
> For full platform detail (nexlayer.yaml schema, Dockerfile rules, CI/CD, task recipes) read **`nexlayer.skills`** in this repo.
>
> **Critical rules (full detail in `nexlayer.skills`):**
> - Inter-pod refs: `${podName:port}` only — never `localhost` or bare hostnames
> - Docker Hub images: prefix with `mirror.gcr.io/library/` — bare tags fail on the cluster
> - Secrets: set in the Nexlayer dashboard — never commit to `nexlayer.yaml` or Dockerfile
>
> **This file:** `agent-managed` sections update automatically. `user-editable` sections (Local Development Setup, Nexlayer Deployment Plan, Build Notes) are yours — preserved across re-analysis.

## Project Summary
<!-- nexlayer:section agent-managed=project_summary -->
An AI-powered demo using Expo Router with universal React Server Components (RSC) to stream native UI responses from an AI chat interface.
<!-- nexlayer:end -->

## Technology Stack
<!-- nexlayer:section agent-managed=tech_stack -->
| Name | Kind | Version | Detected From |
|------|------|---------|---------------|
| Expo | framework | 54.0.27 | package.json |
| React Native | framework | 0.81.5 | package.json |
| AI SDK (Vercel) | ml | 3.4.33 | package.json |
| Node.js | language | >=20 | package.json |
| Tailwind CSS | tool | latest | tailwind.config.js |
<!-- nexlayer:end -->

## Repository Structure
<!-- nexlayer:section agent-managed=structure_map -->
- app/ — Expo Router file-based routing and RSC pages
- components/ — Reusable UI components for native and web
- util/ — Shared utility functions
- assets/ — Static images and fonts
- fixtures/ — Mock data for AI tool calls
<!-- nexlayer:end -->

## External Services Required
<!-- nexlayer:section agent-managed=external_deps -->
Services that must be configured separately (not deployed by Nexlayer):

- OpenAI API (OPENAI_API_KEY)
- Weather API (WEATHER_API_KEY)
- The MovieDB API (TMDB_API_KEY, TMDB_READ_ACCESS_TOKEN)
- Google Maps API (GOOGLE_MAPS_API_KEY)
- Apple MapKit JS (EXPO_PUBLIC_APPLE_MAPKIT_JS_KEY)
<!-- nexlayer:end -->

## Local Development Setup
<!-- nexlayer:section user-editable=local_setup -->
### Prerequisites

- Node.js >= 20
- npm or yarn
- Expo Go (mobile) or Web Browser

### Environment variables

Copy `.env.example` to `.env.local` and fill in:

```
OPENAI_API_KEY=sk-***
WEATHER_API_KEY=***
TMDB_API_KEY=***
TMDB_READ_ACCESS_TOKEN=***
GOOGLE_MAPS_API_KEY=***
EXPO_PUBLIC_APPLE_MAPKIT_JS_KEY=***
```

### Steps

1. `npm install` — Install project dependencies
2. `npx expo start` — Start the Expo development server
3. `npx expo start --web` — Start the web version of the app

<!-- nexlayer:end -->

## Nexlayer Setup
<!-- nexlayer:section agent-managed=nexlayer_setup -->
### Pod Environment Variables

| Pod | Variable | Value | Kind |
|-----|----------|-------|------|
| `app` | `NODE_ENV` | `"production"` | plain |
| `app` | `PORT` | `"8081"` | plain |
| `app` | `HOSTNAME` | `"0.0.0.0"` | plain |
| `app` | `OPENAI_API_KEY` | `"${OPENAI_API_KEY}"` | inter-pod |
| `app` | `WEATHER_API_KEY` | `"${WEATHER_API_KEY}"` | inter-pod |
| `app` | `TMDB_API_KEY` | `"${TMDB_API_KEY}"` | inter-pod |
| `app` | `TMDB_READ_ACCESS_TOKEN` | `"${TMDB_READ_ACCESS_TOKEN}"` | inter-pod |
| `app` | `GOOGLE_MAPS_API_KEY` | `"${GOOGLE_MAPS_API_KEY}"` | inter-pod |
| `app` | `EXPO_PUBLIC_APPLE_MAPKIT_JS_KEY` | `${EXPO_PUBLIC_APPLE_MAPKIT_JS_KEY}` | inter-pod |

### nexlayer.yaml

```yaml
application:
  name: expo-ai
  pods:
    - name: app
      image: "registry.nexlayer.io/user_01kna6j8vrcfj9q0wjtq5qsq3n/expo-ai:19f19038f16"
      path: /
      servicePorts:
        - 8081
      vars:
        NODE_ENV: "production"
        PORT: "8081"
        HOSTNAME: "0.0.0.0"
        OPENAI_API_KEY: "${OPENAI_API_KEY}"
        WEATHER_API_KEY: "${WEATHER_API_KEY}"
        TMDB_API_KEY: "${TMDB_API_KEY}"
        TMDB_READ_ACCESS_TOKEN: "${TMDB_READ_ACCESS_TOKEN}"
        GOOGLE_MAPS_API_KEY: "${GOOGLE_MAPS_API_KEY}"
        EXPO_PUBLIC_APPLE_MAPKIT_JS_KEY: ${EXPO_PUBLIC_APPLE_MAPKIT_JS_KEY}
```

<!-- nexlayer:end -->

## Nexlayer Deployment Plan
<!-- nexlayer:section user-editable=deployment_plan -->
### Pod Topology

| Pod | Image | Port | Role |
|-----|-------|------|------|
| expo-server | mirror.gcr.io/library/node:22-alpine | 8081 | web |

### Deployment notes

- This application is a frontend-heavy Expo project using RSC; the 'expo-server' pod handles both the bundling/serving and the server-side AI logic.
- No internal database pod is required as the project relies on external APIs for data (OpenAI, TMDB, WeatherAPI).
- Ensure all API keys are injected as secrets into the expo-server pod.

<!-- nexlayer:end -->

## Build Notes
<!-- nexlayer:section user-editable=build_notes -->
<!-- Add notes for future builds here — preserved across re-analysis -->
<!-- nexlayer:end -->

## Nexlayer Configuration
<!-- nexlayer:section agent-managed=nexlayer_config -->
**Last deployed:** 2026-06-30T14:54:11Z  
**Live URL:** https://kitbear-studio-expo-ai.cloud.nexlayer.ai  
**Runtime:** node · **Port:** 8081  
**Deploy branch:** main  

```yaml
application:
  name: expo-ai
  pods:
    - name: app
      image: "registry.nexlayer.io/user_01kna6j8vrcfj9q0wjtq5qsq3n/expo-ai:19f19038f16"
      path: /
      servicePorts:
        - 8081
      vars:
        NODE_ENV: "production"
        PORT: "8081"
        HOSTNAME: "0.0.0.0"
        OPENAI_API_KEY: "${OPENAI_API_KEY}"
        WEATHER_API_KEY: "${WEATHER_API_KEY}"
        TMDB_API_KEY: "${TMDB_API_KEY}"
        TMDB_READ_ACCESS_TOKEN: "${TMDB_READ_ACCESS_TOKEN}"
        GOOGLE_MAPS_API_KEY: "${GOOGLE_MAPS_API_KEY}"
        EXPO_PUBLIC_APPLE_MAPKIT_JS_KEY: ${EXPO_PUBLIC_APPLE_MAPKIT_JS_KEY}
```
<!-- nexlayer:end -->

## Build History
<!-- nexlayer:section agent-managed=build_history -->
| Date | Status | Notes |
|------|--------|-------|
| 2026-06-30T14:51:58Z | analyzed | initial repo analysis |
| 2026-06-30T14:54:11Z | success | deployed https://kitbear-studio-expo-ai.cloud.nexlayer.ai |
<!-- nexlayer:end -->
