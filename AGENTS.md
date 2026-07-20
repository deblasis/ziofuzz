# ziofuzz

## Overview

Small random property testing library for Zig. Generates random and edge-biased inputs, runs a property a fixed number of times, and can randomly shrink a single failing input. There is no coverage instrumentation and no corpus. It runs inside `zig test` like any other test.

## Project Structure

```
src/
  ziofuzz.zig    - Main library source
examples/
  example.zig    - Runnable example
build.zig        - Build configuration
```

## Commands

```bash
zig build test          # Run tests
zig build run-example   # Run the example
zig fmt --check .       # Check formatting
```

## Architecture

Single-file library with no external dependencies. All public symbols have doc comments.

## Testing

Tests are inline in `src/ziofuzz.zig`. Run with `zig build test`.
