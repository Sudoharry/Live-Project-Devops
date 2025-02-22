FROM node:17.9.0-slim 
LABEL maintainer="DeekshithSN"
RUN useradd admin-ui
WORKDIR /app
COPY . .
RUN npm install
EXPOSE 3000
USER admin-ui
CMD ["npm","start"]