FROM node:10.3.0 as build
WORKDIR /app
COPY package.json .
COPY package-lock.json .
RUN npm install ci

FROM arm32v7/node:alpine
COPY --from=build /app/node_modules node_modules
COPY index.html ppt.js ./
COPY DOCKER_README.md ABOUT_DOCKER.md WHERE_USING_DOCKER.md ./
COPY examples examples
COPY img img
COPY entrypoint.sh entrypoint.sh
RUN chmod +x entrypoint.sh

EXPOSE 8080
ENTRYPOINT ["./entrypoint.sh"]

