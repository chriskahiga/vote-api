FROM registry.redhat.io/ubi8/go-toolset:1.14.12 as builder

WORKDIR /build
ADD . /build/

RUN CGO_ENABLED=0 go build -mod=vendor -o api-server .

FROM scratch

WORKDIR /app
COPY --from=builder /build/api-server /app/api-server

CMD [ "/app/api-server" ]
