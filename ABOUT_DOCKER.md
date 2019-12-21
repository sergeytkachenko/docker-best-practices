# Docker introduction

* Docker concepts
    * **build, share, and run** applications with containers
    * **Flexible**: Even the most complex applications can be containerized.
    * **Lightweight**: Containers leverage and share the host kernel, 
    making them much more efficient in terms of system resources than virtual machines.
    * **Portable**: You can build locally, deploy to the cloud, and run anywhere.
    * **Loosely coupled**: Containers are highly self sufficient and encapsulated, 
    allowing you to replace or upgrade one without disrupting others.
    * **Scalable**: You can increase and automatically distribute container replicas across a datacenter.
    * **Secure**: Containers apply aggressive constraints and isolations to processes 
    without any configuration required on the part of the user.
    * **image** - private filesystem
    * **container** - isolation running process with private filesystem
* Dockerfile syntax
* Docker context ```docker context``` is not a **build context**
    * What is context of the docker daemon?
        * File system cache
    * What is the purpose of the Docker build context?
        * Because the client and daemon may not even run on the same machine
        * ```COPY```, ```ADD``` move files from context to result image 
    * **with .git** folder ```Sending build context to Docker daemon 9.58MB```
    * **without .git** folder ```Sending build context to Docker daemon  4.952MB```
    * Build with different context type 
        * from filesystem ```docker build -t gs .```
        * from git ```docker build -t gs http://globalsearch.git```
        * from .tar.gz ```docker build -t gs globalsearch.tar.gz```
    * ```.dockerignore```
* Cache 
    * Lifecycle of the cache
        * ```RUN```
        * ```ADD```
        * ```COPY```
* Debugging build steps of the Dockerfile
* Debug running container or pulled image
* BuildKit
    * Benchmarks
    * Difference build context
        * ```--mount=type=*```
