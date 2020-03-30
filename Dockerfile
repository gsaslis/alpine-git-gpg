FROM alpine/git:latest

RUN apk update && apk add --no-cache gnupg
