FROM node:10.3.0
WORKDIR /app
COPY package.json .
COPY package-lock.json .
RUN npm install ci

COPY index.html ppt.js ./
COPY DOCKER_README.md ABOUT_DOCKER.md WHERE_USING_DOCKER.md ./
COPY examples examples
COPY img img

EXPOSE 8080
CMD [ "node", "ppt.js" ]

