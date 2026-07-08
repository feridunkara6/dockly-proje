# Dockly API — multi-stage (docs/24 §17, docs/28 §4). Tek imaj: api + worker (CMD farkı).
# Taban: node:22-slim (Node 20 LTS desteği Nisan 2026'da bitti — güvenlik yamaları için 22 LTS).
# Teknik borç (Faz 2'de kapanır): lockfile üretilince `npm ci`ya dönülecek.
FROM node:22-slim AS deps
WORKDIR /app
COPY package.json ./
COPY prisma ./prisma
RUN npm install --no-audit --no-fund && npx prisma generate

FROM node:22-slim AS build
WORKDIR /app
COPY --from=deps /app/node_modules ./node_modules
COPY . .
RUN npm run build && npm prune --omit=dev && npx prisma@5.22.0 generate

FROM node:22-slim AS runtime
ENV NODE_ENV=production
WORKDIR /app
# openssl: Prisma query engine'in çalışma zamanı bağımlılığı (slim imajda gelmez);
# upgrade: taban katmandaki düzeltmesi yayınlanmış CVE'leri kapatır (Trivy kapısı).
RUN apt-get update \
  && apt-get upgrade -y \
  && apt-get install -y --no-install-recommends openssl libssl3 \
  && rm -rf /var/lib/apt/lists/*
# Çalışma zamanında paket yöneticisine ihtiyaç yok: npm/npx/corepack/yarn imajdan
# çıkarılır — tabanla gelen bağımlılık CVE'leri (sigstore/picomatch) ve saldırı
# yüzeyi birlikte gider (docs/29 hardening ilkesi).
RUN rm -rf /usr/local/lib/node_modules /usr/local/bin/npm /usr/local/bin/npx \
  /usr/local/bin/corepack /opt/yarn* /usr/local/bin/yarn /usr/local/bin/yarnpkg
RUN groupadd -r dockly && useradd -r -g dockly dockly
COPY --from=build /app/node_modules ./node_modules
COPY --from=deps /app/node_modules/.prisma ./node_modules/.prisma
COPY --from=build /app/dist ./dist
COPY --from=build /app/prisma ./prisma
COPY --from=build /app/package.json ./package.json
USER dockly
EXPOSE 3000
CMD ["node", "dist/main.js"]
