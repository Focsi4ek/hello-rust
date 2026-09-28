FROM rust:1-slim AS builder

WORKDIR /build

COPY Cargo.toml Cargo.lock ./
COPY src ./src

RUN cargo build --release


FROM debian:stable-slim

RUN useradd --create-home appuser

WORKDIR /home/appuser

COPY --from=builder /build/target/release/hello-rust ./hello-rust

USER appuser

ENTRYPOINT ["./hello-rust"]

