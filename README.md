# ziofuzz

> **Note:** Zig 0.16 ships with [`std.testing.fuzz`](https://github.com/ziglang/zig/blob/master/lib/std/testing.zig#L1243) and [`std.testing.Smith`](https://github.com/ziglang/zig/blob/master/lib/testing/Smith.zig), a coverage-guided fuzzer with structured value generation, corpus management, and build system integration via `zig build fuzz`.
> **Use `std.testing.fuzz` for production code.**
>
> ziofuzz was a learning exercise to understand property-based and fuzz testing concepts before discovering the stdlib implementation. It remains here as a simple, dependency-free property-based tester that runs inside `zig test` without needing the fuzz build step.

## What `std.testing.fuzz` gives you

```zig
const std = @import("std");

// Coverage-guided fuzzing with structured input via Smith
test "fuzz adder" {
    try std.testing.fuzz({}, struct {
        fn testOne(context: void, smith: *std.testing.Smith) !void {
            const a = smith.value(i32);
            const sum = try std.math.add(i32, a, 100);
            try std.testing.expect(sum >= a);
        }
    }.testOne, .{});
}
```

Run with: `zig build fuzz` — coverage-guided, parallel, corpus-managed.

## When ziofuzz might still be useful

- **No fuzz build step needed** — runs inside `zig test` like any other test
- **Simple property-based testing** — `fuzz1(T, property, config)` is quick to write
- **Edge case generation** — `edgeCases(T)` gives you boundary values without setting up Smith
- **Learning/reference** — straightforward implementation of random + edge-case + shrink

```zig
const ziofuzz = @import("ziofuzz");

// Quick property check — no build step, runs in `zig test`
try ziofuzz.fuzz1(u8, struct {
    fn check(x: u8) bool { return x + 0 == x; }
}.check, .{ .max_iterations = 1000 });

// Edge cases for a type
const cases = ziofuzz.edgeCases(u8); // [0, 1, 127, 128, 254, 255]
```

## License

MIT. Copyright (c) 2026 Alessandro De Blasis.
