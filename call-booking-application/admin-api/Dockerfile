# ------------------------------
# Stage 1: Builder Stage
# ------------------------------

FROM node:17.9.0-slim AS builder

LABEL maintainer="HarendraB"

RUN useradd -m adminapi && \
    mkdir -p /home/adminapi && \
    chown -R adminapi:adminapi /home/adminapi

WORKDIR /home/adminapi/app

COPY --chown=adminapi:adminapi package*.json ./

RUN npm ci --production

COPY --chown=adminapi:adminapi . .


# ------------------------------
# Stage 2: Production Stage
# ------------------------------

FROM node:17.9.0-slim

LABEL maintainer="HarendraB"

RUN useradd -m adminapi && \
    mkdir -p /home/adminapi && \
    chown -R adminapi:adminapi /home/adminapi   

WORKDIR /home/adminapi/app

COPY --chown=adminapi:adminapi --from=builder /home/adminapi/app /home/adminapi/app

RUN chmod -R 750 /home/adminapi/app

EXPOSE 1004

USER adminapi

ENV MONGO_URL=""

CMD ["npm","start"]