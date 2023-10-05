FROM golang:1.18-alpine as builder

RUN mkdir /app

COPY . /app

WORKDIR /app

# CGO_ENABLED is to run docker image from scratch
RUN CGO_ENABLED=0 go build -o brokerApp ./cmd/api

# build tiny docker image

FROM alpine:latest

RUN mkdir /app

COPY --from=builder /app/brokerApp /app

CMD ["/app/brokerApp"]