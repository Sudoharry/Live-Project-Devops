# ------------------------------
# Stage 1: Builder Stage
# ------------------------------

FROM node:17.9.0-slim AS builder

LABEL maintainer="HarendraB"

RUN useradd -m userapi && \
    mkdir -p /home/userapi && \
    chown -R userapi:userapi /home/userapi

WORKDIR /home/userapi/app

COPY --chown=userapi:userapi package*.json ./

RUN npm ci --production

COPY  --chown=userapi:userapi . .   

# ------------------------------
# Stage 2: Production Stage
# ------------------------------

FROM node:17.9.0-slim 

LABEL maintainer="HarendraB"

RUN useradd -m userapi && \
    mkdir -p /home/userapi && \
    chown -R userapi:userapi /home/userapi

WORKDIR /home/userapi/app

COPY --chown=userapi:userapi --from=builder /home/userapi/app /home/userapi/app

EXPOSE 1004

USER userapi

ENV MONGO_URL=""
ENV ADMIN_EMAIL=""

CMD ["npm","start"]
