FROM node:16-alpine AS builder
WORKDIR /ui
COPY package*.json ./
RUN apk update \
  && apk add git \
  && npm i
COPY . .
RUN npm run build

FROM nginx:alpine
WORKDIR /usr/share/nginx/html
RUN rm -rf ./*
COPY --from=builder /ui/build .
ENTRYPOINT [ "nginx", "-g", "daemon off;" ]
