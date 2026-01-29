# -------- Build stage --------
FROM node:16-alpine AS builder

WORKDIR /app

# Copy only dependency files first (better caching)
COPY package.json yarn.lock ./

# Install only production deps needed for build
RUN yarn install --frozen-lockfile

# Copy source
COPY . .

# Build-time variables
ARG TMDB_V3_API_KEY
ENV VITE_APP_TMDB_V3_API_KEY=$TMDB_V3_API_KEY \
    VITE_APP_API_ENDPOINT_URL=https://api.themoviedb.org/3

# Build app
RUN yarn build


# -------- Runtime stage --------
FROM nginx:stable-alpine

# Remove default nginx static assets
RUN rm -rf /usr/share/nginx/html/*

# Copy only the built files (very small)
COPY --from=builder /app/dist /usr/share/nginx/html

# Expose HTTP port
EXPOSE 80

# Run nginx
CMD ["nginx", "-g", "daemon off;"]

