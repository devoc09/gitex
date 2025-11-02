const std = @import("std");
const c = @cImport({
    @cInclude("git2.h");
});

pub fn main() !void {
    // initialize libgit2
    _ = c.git_libgit2_init();
    defer _ = c.git_libgit2_shutdown();

    var repo: ?*c.git_repository = null;
    const path = ".";

    const err = c.git_repository_open(&repo, path);
    if (err < 0) {
        const git_err = c.git_error_last();
        if (git_err) |e| {
            std.debug.print("DEBUG: Error {s}\n", .{e.*.message});
        }

        return error.GitError;
    }

    defer c.git_repository_free(repo);

    std.debug.print("Repository Opened successfully\n", .{});
}
