# ziofuzz

Fuzz testing for Zig. Random value generation, edge cases, property-based shrinking.

## The pitch

Generate random and edge-case values for fuzz testing. Run property checks with configurable iterations.

```zig
const ziofuzz = @import("ziofuzz");

// Test a property with random inputs (auto-finds counterexamples)
try ziofuzz.fuzz1(u8, struct {
    fn check(x: u8) bool { return x < 200; }
}.check, .{ .max_iterations = 1000 });

// Get edge cases for a type
const cases = ziofuzz.edgeCases(u8); // [0, 1, 127, 128, 254, 255]

// Generate random values
var prng = std.Random.DefaultPrng.init(42);
const val = ziofuzz.randomValue(u32, prng.random());
const biased = ziofuzz.edgeValue(u8, prng.random()); // biased toward boundaries

// Shrink a failing input
const minimal = ziofuzz.shrink1(u8, property, failing_input);
```

## Install

```bash
zig fetch --save git+https://github.com/deblasis/ziofuzz
```

Then in your `build.zig`:

```zig
const dep = b.dependency("ziofuzz", .{
    .target = target,
    .optimize = optimize,
});
exe.root_module.addImport("ziofuzz", dep.module("ziofuzz"));
```

Requires Zig 0.16.

## API

- `fuzz1(T, checker, config)` / `fuzz2(T1, T2, checker, config)` — run property checks
- `randomValue(T, rng)` / `edgeValue(T, rng)` — value generation
- `edgeCases(T)` — boundary values
- `shrink1(T, property, input)` — minimize failing input

## Compatibility

- **Zig**: 0.16.0
- **Platforms**: Linux, macOS, Windows
- **Breaking changes**: follows [Semantic Versioning](https://semver.org/spec/v2.0.0.html). Minor versions add features, patch versions fix bugs.

## License

MIT. Copyright (c) 2026 Alessandro De Blasis.
