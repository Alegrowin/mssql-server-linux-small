FROM debian:stretch-slim AS build0

RUN apt-get update && apt-get install -y binutils gcc

WORKDIR /build
COPY wrapper.c /build/

RUN gcc -shared  -ldl -fPIC -o wrapper.so wrapper.c

FROM mcr.microsoft.com/mssql/server:2019-latest
COPY --from=build0 /build/wrapper.so /root/

CMD LD_PRELOAD=/root/wrapper.so /opt/mssql/bin/sqlservr
