# ziofuzz

## Overview

Fuzz testing library for Zig. Provides coverage-guided fuzzing, corpus management, and integration with zig test. Generate random inputs, find edge cases, and shrink failures to minimal reproducing cases.

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
zig build               - Build the library
```

## Architecture

Single-file library with no external dependencies. All public symbols have doc comments.

## Testing

Tests are inline in `src/ziofuzz.zig`. Run with `zig build test`.
