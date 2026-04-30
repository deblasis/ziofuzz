const std = @import("std");
const ziofuzz = @import("ziofuzz");

pub fn main() !void {
    std.debug.print("=== ziofuzz example ===\n\n", .{});

    // Demo: random value generation
    var prng = std.Random.DefaultPrng.init(42);
    std.debug.print("Random u8: {d}\n", .{ziofuzz.randomValue(u8, prng.random())});
    std.debug.print("Random i32: {d}\n", .{ziofuzz.randomValue(i32, prng.random())});
    std.debug.print("Random bool: {}\n", .{ziofuzz.randomValue(bool, prng.random())});
    std.debug.print("Random f64: {d:.4}\n", .{ziofuzz.randomValue(f64, prng.random())});

    // Demo: edge cases
    std.debug.print("\nEdge cases for u8: {any}\n", .{ziofuzz.edgeCases(u8)});
    std.debug.print("Edge cases for i32: {any}\n", .{ziofuzz.edgeCases(i32)});
    std.debug.print("Edge cases for bool: {any}\n", .{ziofuzz.edgeCases(bool)});

    // Demo: edge-biased generation
    std.debug.print("\nEdge-biased u8 values:\n", .{});
    var i: usize = 0;
    while (i < 10) : (i += 1) {
        std.debug.print("  {d}\n", .{ziofuzz.edgeValue(u8, prng.random())});
    }

    // Demo: fuzz testing
    std.debug.print("\nFuzz testing: addition is commutative (1000 iterations)...\n", .{});
    ziofuzz.fuzz2(u8, u8, struct {
        fn check(a: u8, b: u8) !void {
            const sum1 = @as(u16, a) + @as(u16, b);
            const sum2 = @as(u16, b) + @as(u16, a);
            if (sum1 != sum2) return error.NotCommutative;
        }
    }.check, .{ .max_iterations = 1000 }) catch |err| {
        std.debug.print("  FAILED: {s}\n", .{@errorName(err)});
        std.process.exit(1);
    };
    std.debug.print("  PASSED!\n", .{});

    std.debug.print("\nAll demos completed.\n", .{});
}
