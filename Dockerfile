## Build
FROM golang:1.18 AS build

WORKDIR /usr/src/app

COPY . .
RUN go mod download && go mod verify
RUN go build -v -o /usr/local/bin/app ./...


## Deploy
FROM gcr.io/distroless/base-debian10

WORKDIR /
COPY --from=build /usr/local/bin/app ./
ENTRYPOINT ["./app"]
