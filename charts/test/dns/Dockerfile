# Build Stage
FROM node:alpine as build-stage
WORKDIR /app
COPY . .
RUN npm i vite && npm run build

# Runtime Stage
FROM nginx:alpine
COPY --from=build-stage /app/dist /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
