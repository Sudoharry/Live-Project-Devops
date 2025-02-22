FROM node:17.9.0-slim
LABEL maintainer="DeekshithSN"
WORKDIR /app
RUN useradd user-api
EXPOSE 1004
COPY . /app
RUN npm install
ENV MONGO_URL=""
ENV ADMIN_EMAIL=""
USER user-api
CMD ["npm","start"]