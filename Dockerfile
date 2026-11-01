# 多阶段构建：Node 构建前端 + Nginx 托管静态产物
# 用法: docker build -t ai-pose-gallery-zh . && docker run -p 8088:80 ai-pose-gallery-zh
FROM node:22-slim AS build
WORKDIR /app
RUN npm install -g pnpm
COPY . .
RUN bash scripts/build.sh

FROM nginx:alpine
COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=build /app/dist /usr/share/nginx/html
EXPOSE 80
