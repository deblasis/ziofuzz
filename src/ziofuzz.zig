//! Coverage-guided fuzzing for Zig

const std = @import("std");

test "{ziofuzz} smoke test" {
    try std.testing.expect(true);
}
