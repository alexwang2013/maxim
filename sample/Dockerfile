FROM golang:1.16-buster as builder

# Create and change to the app directory.
WORKDIR /app

COPY go.mod .
RUN go mod download

# Copy local code to the container image.
COPY main.go ./

# Build the binary.
RUN go build -v -o server

# using small size of base image
FROM debian:buster-slim
RUN set -x && apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    ca-certificates && \
    rm -rf /var/lib/apt/lists/*

# Copy the binary to the production image from the builder stage.
COPY --from=builder /app/server /app/server

# Run the web service on container startup.
CMD ["/app/server"]