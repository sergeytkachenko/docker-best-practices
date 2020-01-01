# docker build -f examples/cache/Dockerfile -t example_cache .
FROM alpine:3.11
# generated random symbols
RUN head -c 20 /dev/urandom > file_with_random_content.txt
RUN cat file_with_random_content.txt

