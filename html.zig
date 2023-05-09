const std = @import("std");

const TagFn = fn (comptime []const u8) []const u8;


pub fn Tag(comptime tag: []const u8) TagFn {
    const Closure = struct {
        fn tagfn(comptime text: []const u8) []const u8 {
            return
                "<"++tag++">" ++
                text ++
                "</"++tag++">";
        }
    };
    return Closure.tagfn;
}

const html_ = Tag("html");
const head_ = Tag("head");
const body_ = Tag("body");
const title_ = Tag("title");
const p_ = Tag("p");
const h1_ = Tag("h1");

pub fn main() !void {
    const doc = comptime "<!DOCTYPE html>\n" ++ html_(
        head_(
            title_("title")
        ) ++
        body_(
            h1_("HEADER") ++
            p_("paragraph")
        )
    );

    const stdout = std.io.getStdOut().writer();
    try stdout.print("{s}\n", .{doc});
}