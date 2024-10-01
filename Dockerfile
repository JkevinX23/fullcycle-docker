# Etapa de build
FROM golang:alpine AS builder

WORKDIR /app

COPY go.mod . 

RUN go mod tidy

COPY main.go .

RUN CGO_ENABLED=0 GOOS=linux go build -ldflags="-s -w" -o fullcycle .

FROM scratch

COPY --from=builder /app/fullcycle .

CMD ["./fullcycle"]
