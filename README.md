# opencode

Configuration repository and container image for OpenCode.

## Neovim prompt editor

The image uses Neovim as its editor. Its baked-in configuration provides
Markdown syntax highlighting, soft-wrapped prose, wrapped-line `j`/`k`
navigation, and English spell checking for Markdown files. No plugins are
installed, so the editor remains small and works without runtime downloads.

Useful spell-check commands are `[s` and `]s` to move between misspellings,
`z=` for suggestions, and `zg` to add a word to the persistent personal
dictionary.

Build the image tag used by the launcher, then source the launcher to make the
`oc` shell function available:

```sh
docker build -t test/opencode:v1 .
source ./run-command.sh
oc
```

The launcher requires Bash or Zsh. It persists Neovim's data directory, so
spellings added with `zg` survive container recreation.

Neovim and OpenCode configuration are baked into the image; rebuild after
changing files under `configs/` or `agents/`.
