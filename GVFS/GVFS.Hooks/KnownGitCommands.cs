using System.Collections.Generic;

namespace GVFS.Hooks
{
    internal static class KnownGitCommands
    {
        private static HashSet<string> knownCommands = new HashSet<string>()
        {
            "add",
            "am",
            "annotate",
            "apply",
            "archive",
            "bisect--helper",
            "blame",
            "branch",
            "bundle",
            "cat-file",
            "check-attr",
            "check-ignore",
            "check-mailmap",
            "check-ref-format",
            "checkout",
            "checkout-index",
            "cherry",
            "cherry-pick",
            "clean",
            "clone",
            "column",
            "commit",
            "commit-tree",
            "config",
            "count-objects",
            "credential",
            "describe",
            "diff",
            "diff-files",
            "diff-index",
            "diff-tree",
            "fast-export",
            "fetch",
            "fetch-pack",
            "fmt-merge-msg",
            "for-each-ref",
            "format-patch",
            "fsck",
            "fsck-objects",
            "gc",
            "get-tar-commit-id",
            "grep",
            "hash-object",
            "help",
            "index-pack",
            "init",
            "init-db",
            "interpret-trailers",
            "log",
            "ls-files",
            "ls-remote",
            "ls-tree",
            "mailinfo",
            "mailsplit",
            "merge",
            "merge-base",
            "merge-file",
            "merge-index",
            "merge-ours",
            "merge-recursive",
            "merge-recursive-ours",
            "merge-recursive-theirs",
            "merge-subtree",
            "merge-tree",
            "mktag",
            "mktree",
            "mv",
            "name-rev",
            "notes",
            "pack-objects",
            "pack-redundant",
            "pack-refs",
            "patch-id",
            "pickaxe",
            "prune",
            "prune-packed",
            "pull",
            "push",
            "read-tree",
            "rebase",
            "rebase--helper",
            "receive-pack",
            "reflog",
            "remote",
            "remote-ext",
            "remote-fd",
            "repack",
            "replace",
            "rerere",
            "reset",
            "restore",
            "rev-list",
            "rev-parse",
            "revert",
            "rm",
            "send-pack",
            "shortlog",
            "show",
            "show-branch",
            "show-ref",
            "stage",
            "status",
            "stripspace",
            "switch",
            "symbolic-ref",
            "tag",
            "unpack-file",
            "unpack-objects",
            "update-index",
            "update-ref",
            "update-server-info",
            "upload-archive",
            "upload-archive--writer",
            "var",
            "verify-commit",
            "verify-pack",
            "verify-tag",
            "version",
            "whatchanged",
            "worktree",
            "write-tree",

            // Externals
            "bisect",
            "filter-branch",
            "gui",
            "merge-octopus",
            "merge-one-file",
            "merge-resolve",
            "mergetool",
            "parse-remote",
            "quiltimport",
            "rebase",
            "submodule",
        };

        public static bool Contains(string gitCommand)
        {
            return knownCommands.Contains(gitCommand);
        }
    }
}
