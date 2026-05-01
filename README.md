# weiesky/homebrew-cc-viewer

Homebrew tap for [cc-viewer](https://github.com/weiesky/cc-viewer) — Vibe Coding toolkit for Claude Code with Web Viewer + Logger.

## Install

```bash
brew tap weiesky/cc-viewer
brew install cc-viewer
```

## Update

```bash
brew upgrade cc-viewer
```

## Why this tap?

For users with `nvm`: when you switch Node versions (`nvm use <other>`), the npm-global install of `ccv` appears to "disappear" because nvm rewrites PATH to a per-version bin directory. This Homebrew tap installs ccv to a stable location (`<prefix>/Cellar/cc-viewer/`) and pins the runtime to Homebrew's own Node binary, so `nvm use` does not affect it.

cc-viewer's auto-updater detects Homebrew installs and skips the npm-based upgrade path automatically — use `brew upgrade cc-viewer` instead.

## Maintenance

Formula updates are automated by the [`bump-homebrew.yml`](https://github.com/weiesky/cc-viewer/blob/main/.github/workflows/bump-homebrew.yml) workflow in the cc-viewer repo. On every cc-viewer release, that workflow opens a PR here updating the `url` and `sha256` to the latest npm tarball.
