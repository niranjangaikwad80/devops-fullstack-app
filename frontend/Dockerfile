# -----------------------------
# Stage 1: Build the React App
# -----------------------------
FROM node:18 AS build

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .

RUN npm run build  # Generates /app/build

# -----------------------------
# Stage 2: Serve using NGINX
# -----------------------------
FROM nginx:alpine

WORKDIR /usr/share/nginx/html

# Remove default static assets
RUN rm -rf ./*

# Copy static build files
COPY --from=build /app/build .

# Copy runtime env script
COPY public/env-config.js ./env-config.js

# Inject env variables at container startup
CMD /bin/sh -c "envsubst < env-config.js > env.js && nginx -g 'daemon off;'"
