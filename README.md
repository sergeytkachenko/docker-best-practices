## Docker introduction

* Where we [use](WE_USE_DOCKER_IN.md) docker
* See Docker [introduction](ABOUT_DOCKER.md)

## Docker best practices

* Incremental **build time**. **Make build cache** your friend
* Reduce image size (pull, push speed in ci/cd)
    * Remove unnecessary dependencies
    * Remove package manager cache
* Maintainability
    * Dockerfile simple a possible
    * Use official images where possible
* Multi-stage builds
* Use more specific tags
* Look for minimal flavors of image tag
* Reproducibility
    * Build from source in a consistent environment
* Various [environments](https://github.com/docker/cli/tree/master/dockerfiles): build, dev, test, lint, …
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


#### links
* [buildkit](https://www.youtube.com/watch?time_continue=222&v=cbLk3Egc42E&feature=emb_logo)
* https://www.youtube.com/watch?v=JofsaZ3H1qM
* https://blog.codeship.com/3-different-ways-to-provide-docker-build-context/
* https://github.com/moby/buildkit/blob/master/frontend/dockerfile/docs/experimental.md
* https://aboullaite.me/speed-up-your-java-application-images-build-with-buildkit/
* https://www.docker.com/dockercon/2019-videos/
