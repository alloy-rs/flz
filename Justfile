set positional-arguments
alias t := tests
alias l := lint
alias f := fmtf
alias b := build
alias h := hack
alias c := check

# default recipe to display help information
default:
  @just --list

# Run all tests
tests: test test-docs

# Test for the native target with all features. By default, excludes online tests.
test:
  cargo nextest run --all --all-features

# Test the Rust documentation
test-docs:
  cargo test --doc --all

# Lint the workspace for all available targets
lint: lint-native lint-docs

# Lint the workspace
lint-native: fmt-check lint-docs clippy

# Checks with clippy
clippy:
  cargo +stable clippy --all-features --all-targets -- -D warnings

# Check the formatting
fmt-check:
  cargo +nightly fmt --all -- --check

# Lint the Rust documentation
lint-docs:
  RUSTDOCFLAGS="-D warnings" cargo doc --all --no-deps --document-private-items

# Fixes the formatting
fmtf:
  cargo +nightly fmt --all

# Build for the native target
build *args='':
  cargo build $@

# Runs cargo check 
check:
  cargo check

# Runs `cargo hack check` against the workspace
hack:
  cargo hack check --feature-powerset --no-dev-deps --workspace


