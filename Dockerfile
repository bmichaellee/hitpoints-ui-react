FROM node:16 AS builder
WORKDIR /ui
COPY package*.json ./
RUN npm i
COPY ./ .
RUN npm run build

FROM nginx:alpine
WORKDIR /usr/share/nginx/html
RUN rm -rf ./*
COPY --from=builder /ui/build .
ENTRYPOINT [ "nginx", "-g", "daemon off;" ]
