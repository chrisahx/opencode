import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";

/**
 * A small example extension: `/repo-status` shows the current Git branch and
 * working-tree state without asking the model to run a command.
 */
export default function (pi: ExtensionAPI) {
  pi.registerCommand("repo-status", {
    description: "Show the current Git branch and working-tree status",
    handler: async (_args, ctx) => {
      const result = await pi.exec("git", ["status", "--short", "--branch"], {
        signal: ctx.signal,
        timeout: 5_000,
      });

      if (result.code !== 0) {
        ctx.ui.notify("This directory is not a Git repository.", "warning");
        return;
      }

      const status = result.stdout.trim() || "Working tree clean.";
      ctx.ui.notify(status, "info");
    },
  });
}
