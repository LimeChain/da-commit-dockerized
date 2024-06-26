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

# Environment configuration
ARG COMMIT_BOOST_MODULE_ID
ARG COMMIT_BOOST_CONFIG
ENV COMMIT_BOOST_MODULE_ID=${COMMIT_BOOST_MODULE_ID}
ENV COMMIT_BOOST_CONFIG=${COMMIT_BOOST_CONFIG}

CMD ["/usr/local/bin/da_commit"]