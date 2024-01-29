FROM node:18-alpine3.16
RUN apk add --no-cache bash
RUN apk add git --no-cache git
RUN apk update && apk upgrade

WORKDIR /usr/app

COPY ./ /usr/app
COPY release.config.js/ / 
COPY package.json/ /
COPY pipe /
COPY pipe.yml /
COPY ./pipe/ /usr/local/bin

RUN npm install -g semantic-release &&\
npm install -g @semantic-release/changelog &&\
npm install -g @semantic-release/commit-analyzer &&\
npm install -g @semantic-release/git &&\
npm install -g @semantic-release/npm &&\
npm install -g @semantic-release/release-notes-generator &&\
npm install -g semantic-release-ms-teams &&\
npm install -g conventional-changelog-conventionalcommits 

ENTRYPOINT ["/bin/bash", "/pipe.sh"]