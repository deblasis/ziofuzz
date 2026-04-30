# ziofuzz

Coverage-guided fuzzing for Zig

Fuzz testing library for Zig. Provides coverage-guided fuzzing, corpus management, and integration with zig test. Generate random inputs, find edge cases, and shrink failures to minimal reproducing cases.

## Features

- coverage-guided fuzzing engine
- corpus management
- failure shrinking
- custom input generators

## Quick Start

```zig
const ziofuzz = @import("ziofuzz");

pub fn main() !void {
    // See examples/ for runnable code
}
```

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
