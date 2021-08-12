FROM node:16-alpine as builder

ARG BACKEND_URL

WORKDIR /app

COPY package*.json ./

RUN npm ci --no-audit

COPY . .

RUN REACT_APP_BACKEND_URL=$BACKEND_URL npm run build


FROM nginx:stable-alpine

COPY --from=builder /app/build /usr/share/nginx/html

EXPOSE 80

CMD nginx -g daemon off