# Dockly API — multi-stage (docs/24 §17, docs/28 §4). Tek imaj: api + worker (CMD farkı).
FROM node:20-slim AS deps
WORKDIR /app
# Teknik borç (Faz 2'de kapanır): lockfile üretilince `npm ci`ya dönülecek.
COPY package.json ./
COPY prisma ./prisma
RUN npm install --no-audit --no-fund && npx prisma generate

FROM node:20-slim AS build
WORKDIR /app
COPY --from=deps /app/node_modules ./node_modules
COPY . .
RUN npm run build && npm prune --omit=dev

FROM node:20-slim AS runtime
ENV NODE_ENV=production
WORKDIR /app
RUN groupadd -r dockly && useradd -r -g dockly dockly
COPY --from=build /app/node_modules ./node_modules
COPY --from=build /app/dist ./dist
COPY --from=build /app/prisma ./prisma
COPY --from=build /app/package.json ./package.json
USER dockly
EXPOSE 3000
CMD ["node", "dist/main.js"]
