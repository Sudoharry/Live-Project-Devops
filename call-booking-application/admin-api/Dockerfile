FROM node:17.9.0-slim
LABEL maintainer="DeekshithSN"
WORKDIR /app
RUN useradd admin-api
EXPOSE 1004
COPY . /app
RUN npm install
ENV MONGO_URL=""
USER admin-api
CMD ["npm","start"]