# ------------------------------
# Stage 1: Builder Stage
# ------------------------------

FROM node:17.9.0-slim AS builder

LABEL maintainer="HarendraB"

RUN useradd -m userapi && \
    mkdir -p /home/userui && \
    chown -R userui:userui /home/userui

WORKDIR /home/userui/app
 
COPY --chown=userui package*.json ./

RUN npm install --production

COPY --chown=userui:userui . .

USER userui

COPY --chown=userui:userui . .

# ------------------------------
# Stage 2: Production Stage
# ------------------------------

FROM node:17.9.0-slim 

LABEL maintainer="HarendraB"

RUN useradd -m userui && \
    mkdir -p /home/userui && \
    chown -R userui:userui /home/userui

WORKDIR /home/userui/app

COPY --chown=userui:userui --from=builder /home/userui/app /home/userui/app

RUN chmod -R 750 /home/userui/app

EXPOSE 3000

USER userui

CMD ["npm","start"]