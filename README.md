## Docker Training Presentation

* Docker introduction
* Docker best practices

### Development

### Run local

```bash
npm i
npm run start
# open http://localhost:8080
```

### Docker

#### Build 

```bash
docker build -f Dockerfile -t bombascter/docker-intro-ppt .
docker push bombascter/docker-intro-ppt
# open http://localhost
```

#### Run in docker

```bash
docker run -p 80:8080 --rm --name docker-intro-ppt bombascter/docker-intro-ppt
```
