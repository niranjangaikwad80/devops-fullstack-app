# ----- Build Stage -----
FROM golang:1.19 AS build

WORKDIR /app

# Copy go mod files and download dependencies
COPY go.mod go.sum ./
RUN go mod download

# Copy code
COPY . .

# Build binary
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o server main.go


# ----- Run Stage -----
FROM alpine:latest

WORKDIR /root/

# Install CA certificates (important for HTTPS calls)
RUN apk --no-cache add ca-certificates

# Copy built binary
COPY --from=build /app/server .

EXPOSE 8080

CMD ["./server"]
