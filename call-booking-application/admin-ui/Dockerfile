# ------------------------------
# Stage 1: Builder Stage
# ------------------------------

FROM node:17.9.0-slim AS builder

LABEL maintainer="HarendraB"

RUN useradd -m adminui && \
    mkdir -p /home/adminui && \
    chown -R adminui:adminui /home/adminui

WORKDIR /home/adminui/app

COPY --chown=adminui:adminui package*.json ./

RUN npm ci --production

COPY --chown=adminui:adminui . .

# ------------------------------
# Stage 2: Production Stage
# ------------------------------

FROM node:17.9.0-slim 

LABEL maintainer="HarendraB"

RUN useradd -m adminui && \
    mkdir -p /home/adminui && \
    chown -R adminui:adminui /home/adminui

WORKDIR /home/adminui/app

COPY --chown=adminui:admin --from=builder /home/adminui/app /home/adminui/app

RUN chmod -R 750 /app
 
EXPOSE 3000

USER adminui

CMD ["npm","start"]