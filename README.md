# Docker best practices (BuildKit)

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
* Lifecycle of the cache
    * ```RUN```
    * ```ADD```
    * ```COPY```
* Incremental **build time**. **Make build cache** your friend
* Reduce image size (pull, push speed in ci/cd)
    * Remove unnecessary dependencies
    * Remove package manager cache
* Maintainability
    * Dockerfile simple a possible
    * Use official images where possible
* Use more specific tags
* Look for minimal flavors of image tag
* Reproducibility
    * Build from source in a consistent environment
* Multi-stage builds to remove build deps
* Various environments: build, dev, test, lint, …
    * builder: all build dependencies
    * build (or binary): builder + build artifacts
    * cross: same as build but for multiple platforms
    * dev: build(er) + dev/debug tools
    * lint: minimal lint dependencies
    * test: all test dependencies + build artifacts to be tested
    * release: final minimal image with build artifacts
* Concurrency build image
    * From linear Dockerfile stages…
        * all stages are executed in sequence
        * without BuildKit, unneeded stages are unnecessarily but discarded
    * Multi-stage: build concurrently
    * Benchmarks
* New Dockerfile features
    * enabling new features: ```# syntax = docker/dockerfile:experimental```
    * ```RUN --mount=```
    * Secrets
        * private keys (aws)
        * sh (private repositories) ```docker build --ssh=default```
* Demo with non-optimized and optimize build
* Writing Dockerfile
    * Debug build steps
    * Debug completed image

#### links

* https://www.youtube.com/watch?v=JofsaZ3H1qM
* https://blog.codeship.com/3-different-ways-to-provide-docker-build-context/
* https://github.com/moby/buildkit/blob/master/frontend/dockerfile/docs/experimental.md
* https://aboullaite.me/speed-up-your-java-application-images-build-with-buildkit/
