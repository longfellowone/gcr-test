# https://github.com/rust-lang/cargo/issues/2644#issuecomment-660678808
# https://stackoverflow.com/a/59633394/10769162
# https://github.com/rust-lang/cargo/issues/2644
FROM rust:1.46 AS builder
WORKDIR /builder

COPY Cargo.toml .
COPY Cargo.lock .
RUN set -x\
 && mkdir -p src\
 && echo "fn main() {}" > src/main.rs\
 && cargo build --release

COPY src src
RUN set -x\
 && find target/release/ -type f -executable -maxdepth 1 -delete\
 && cargo build --release

FROM rust:1.46-slim
COPY --from=builder /builder/target/release/gcr .

# EXPOSE 8080

CMD ["./gcr"]