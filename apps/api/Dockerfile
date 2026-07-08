# Dockly API — staging imajı (basit ve garantili tek aşama).
# Sertleştirilmiş üretim imajı, AWS üretim fazında geri gelecek.
FROM node:22-bookworm-slim
WORKDIR /app
RUN apt-get update \
  && apt-get install -y --no-install-recommends openssl \
  && rm -rf /var/lib/apt/lists/*
COPY package.json ./
COPY prisma ./prisma
RUN npm install --no-audit --no-fund
COPY . .
RUN npx prisma generate && npm run build
EXPOSE 3000
CMD ["node", "dist/main.js"]
