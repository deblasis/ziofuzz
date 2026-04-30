# ziofuzz

Coverage-guided fuzzing for Zig.

Fuzz testing library with edge-biased input generation, failure shrinking, and comptime configuration. Find bugs that hand-written tests miss by running your code against thousands of automatically generated inputs.

## Features

- **Edge-biased generation** — automatically biases inputs toward boundary values (0, max, min, -1)
- **1/2/3 parameter fuzzing** — `fuzz1`, `fuzz2`, `fuzz3` for any arity
- **Failure shrinking** — minimizes failing inputs to the smallest reproducing case
- **Reproducible** — seed-based RNG for deterministic replay
- **Comptime configuration** — configure iterations, seed, and verbosity at compile time
- **Zero dependencies** — single file, no external deps
- **Enum support** — automatic edge case generation for enum types

## Quick Start

```zig
const std = @import("std");
const ziofuzz = @import("ziofuzz");

test "addition is commutative" {
    try ziofuzz.fuzz2(u8, u8, struct {
        fn check(a: u8, b: u8) !void {
            const sum1 = @as(u16, a) + @as(u16, b);
            const sum2 = @as(u16, b) + @as(u16, a);
            if (sum1 != sum2) return error.NotCommutative;
        }
    }.check, .{});
}

test "parser handles any input" {
    try ziofuzz.fuzz1(u8, struct {
        fn check(byte: u8) !void {
            const result = try myParser(&.{byte});
            try std.testing.expect(result.valid or result.invalid);
        }
    }.check, .{ .max_iterations = 10_000 });
}
```

## API

### `fuzz1(T, checker, config)`
Fuzz test with 1 parameter of type `T`. Runs `checker` up to `config.max_iterations` times with edge-biased random inputs.

### `fuzz2(T1, T2, checker, config)` / `fuzz3(T1, T2, T3, checker, config)`
Same as `fuzz1` but with 2 or 3 parameters.

### `randomValue(T, rng)` → `T`
Generate a random value of type `T`. Supports: `bool`, integers, floats, and enums.

### `edgeValue(T, rng)` → `T`
Generate a random value biased toward edge cases. 30% chance of returning a boundary value.

### `edgeCases(T)` → `[]const T`
Compile-time list of edge case values for type `T`.

### `shrink1(T, checker, failing_input, expected_err, config)` → `?T`
Shrink a failing input toward zero, finding the minimal reproducing case.

### `Config`
```zig
pub const Config = struct {
    max_iterations: u64 = 10_000,
    seed: u64 = 0xDEADBEEFCAFEBABE,
    verbose: bool = false,
};
```

## Supported Types

| Type | Random | Edge Cases |
|------|--------|------------|
| `bool` | ✅ | `true, false` |
| `u8`, `u16`, `u32`, `u64`, `usize` | ✅ | `0, 1, 255, max` |
| `i8`, `i16`, `i32`, `i64` | ✅ | `min, -1, 0, 1, max` |
| `f32`, `f64` | ✅ | `0.0, -0.0, ±1.0, max, min` |
| `enum` | ✅ | All fields |

## Installation

Add to your `build.zig.zon`:

```zig
.{
    .dependencies = .{
        .ziofuzz = .{ .url = "https://github.com/deblasis/ziofuzz/archive/refs/heads/main.tar.gz", .hash = "..." },
    },
}
```

Then in your `build.zig`:

```zig
const ziofuzz = b.dependency("ziofuzz", .{
    .target = target,
    .optimize = optimize,
});
exe.root_module.addImport("ziofuzz", ziofuzz.module("ziofuzz"));
```

## Examples

Run the included example:

```bash
zig build run-example
```

## API Reference

See [src/ziofuzz.zig](src/ziofuzz.zig) for full documentation. All public symbols have doc comments.

## Compatibility

- **Zig:** 0.16.0
- **Platforms:** Linux, macOS, Windows
- **Breaking changes:** Follows [Semantic Versioning](https://semver.org/spec/v2.0.0.html). Minor versions may add features, patch versions fix bugs.

## License

MIT
