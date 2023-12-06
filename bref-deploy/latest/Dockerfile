FROM node:16-alpine

RUN apk add --no-cache bash

RUN apk update && apk add --no-cache aws-cli jq
RUN mkdir /root/.aws && touch /root/.aws/credentials

RUN npm -g update
RUN npm i -g serverless
RUN npm i -g serverless-glue
RUN npm i -g serverless-s3-sync
RUN npm i -g serverless-plugin-lambda-dead-letter
RUN npm i -g serverless-lift
RUN npm i -g serverless-fargate
RUN npm i -g serverless-local-schedule
RUN npm i -g @aws-sdk/client-secrets-manager


COPY pipe /
COPY pipe.yml /
COPY ./pipe/ /usr/local/bin

ENV NODE_PATH=/usr/local/lib/node_modules

RUN chmod +x /usr/local/bin/pipe.sh 

ENTRYPOINT ["/bin/bash", "/pipe.sh"]
