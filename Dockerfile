# Etapa de build
FROM golang:alpine AS builder

WORKDIR /app

# Copie o go.mod primeiro para aproveitar o cache
COPY go.mod . 
RUN go mod tidy

# Copie o código Go para o container
COPY . .

# Compile o código Go para um binário estático
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o fullcycle .

# Imagem final mínima
FROM scratch

# Copie o binário para a imagem final
COPY --from=builder /app/fullcycle .

# Comando para rodar o binário
CMD ["./fullcycle"]
