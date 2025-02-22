FROM node:17.9.0-slim 
LABEL maintainer="DeekshithSN"
RUN useradd user-ui
WORKDIR /app
COPY . .
RUN npm install
EXPOSE 3000
USER user-ui
CMD ["npm","start"]