FROM node:18.9.0-slim

WORKDIR /frontail
ADD . .
RUN npm install --production

ENTRYPOINT ["/frontail/docker-entrypoint.sh"]
EXPOSE 9001
CMD ["--help"]
