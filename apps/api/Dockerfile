# Dockly API — staging imajı (basit ve garantili tek aşama).
# Sertleştirilmiş üretim imajı, AWS üretim fazında geri gelecek.
FROM node:22-bookworm-slim
WORKDIR /app
RUN RUN apt-get update && apt-get upgrade -y \
  && apt-get install -y --no-install-recommends openssl \
  && rm -rf /var/lib/apt/lists/*
COPY package.json ./
COPY prisma ./prisma
RUN npm install --no-audit --no-fund
COPY . .
RUN npx prisma generate && npm run build
RUN rm -rf /usr/local/lib/node_modules /usr/local/bin/npm /usr/local/bin/npx /usr/local/bin/corepack /opt/yarn* /usr/local/bin/yarn /usr/local/bin/yarnpkg
EXPOSE 3000
CMD ["node", "dist/main.js"]
