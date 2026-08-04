FROM golang:1.22 as build
WORKDIR /build
COPY go.mod .
RUN go mod download
COPY . .
RUN go build -o main .
# second stage
FROM gcr.io/distroless/base 
COPY --from=build /build/main .
COPY --from=build /build/static /static
EXPOSE 8080
CMD ["/main"]
