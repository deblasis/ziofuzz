# ziofuzz

Fuzz testing for Zig. Random value generation, edge cases, property-based shrinking.

Generate random and edge-case values for fuzz testing. Run property checks with configurable iterations.

## Quick start

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

## Example output

`zig build run-example` produces:

```
=== ziofuzz example ===

Edge cases for u8: 0, 1, 127, 128, 254, 255

Random u8 values: 37, 139, 208, 52, 193

Running fuzz test on "x < 200"...
  Found failure: error.TooLarge
```

See [examples/example.zig](examples/example.zig) for the source.

## API

- `randomValue(T, rng)` — generate random value for comptime type T
- `edgeValue(T, rng)` — biased toward edge cases
- `edgeCases(T)` — boundary values for type T
- `fuzz1(T, checker, config)` — run property check
- `fuzz2(T1, T2, checker, config)` — run with two args
- `shrink1(T, property, failing_input)` — minimize failing input

## Compatibility

- **Zig**: 0.16.0
- **Platforms**: Linux, macOS, Windows
- **Breaking changes**: follows [Semantic Versioning](https://semver.org/spec/v2.0.0.html). Minor versions add features, patch versions fix bugs.

## License

MIT. Copyright (c) 2026 Alessandro De Blasis.
