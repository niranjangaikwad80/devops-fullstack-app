# ----------------------------- 
# Stage 1: Build the React App 
# ----------------------------- 

FROM node:18 AS build 

WORKDIR /app 

COPY package*.json ./ 

RUN npm install 

COPY . . 

ARG REACT_APP_SERVER_URL
ENV REACT_APP_SERVER_URL=$REACT_APP_SERVER_URL

RUN npm run build # Generates optimized build inside /app/build 
    
# ----------------------------- 
# Stage 2: Run with NGINX 
# ----------------------------- 

FROM nginx:alpine 

# Remove default nginx static assets 
RUN rm -rf /usr/share/nginx/html/* 

# Copy React build artifacts 
COPY --from=build /app/build /usr/share/nginx/html 

# Expose port 3000 
EXPOSE 80

# Start nginx 
CMD ["nginx", "-g", "daemon off;"]
