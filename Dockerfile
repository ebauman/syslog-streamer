FROM golang:1.21 as build

COPY . /app

WORKDIR /app

RUN go get -v ./...

RUN CGO_ENABLED=0 go install -v

FROM alpine:latest as run

COPY --from=build /go/bin/syslog-streamer /syslog-streamer

EXPOSE 514

ENTRYPOINT /syslog-streamer