# Build
FROM rust:latest as build

WORKDIR /build
# # Local commit-boost dev dependency
# COPY cb cb

COPY src src
COPY Cargo.toml Cargo.toml
COPY Cargo.lock Cargo.lock

RUN cargo build --release

# Run
FROM ubuntu:latest

COPY --from=build /build/target/release/da_commit /usr/local/bin/da_commit

CMD ["/usr/local/bin/da_commit"]