# git-rg Homebrew Tap

This tap packages the verified prebuilt `git-rg` archives published by
[`SamuelSupe/git-rg`](https://github.com/SamuelSupe/git-rg). It is not a
second source tree: the formula is generated from the latest stable GitHub
Release and its `checksums.txt`.

## Install

```sh
brew install SamuelSupe/tap/git-rg
git-rg --version
```

Upgrade and remove it with:

```sh
brew upgrade SamuelSupe/tap/git-rg
brew uninstall git-rg
```

The tap supports Homebrew on Linux and macOS for amd64 (x86_64) and arm64.
The installed program searches GitHub/GitLab through their APIs; installing it
does not clone or checkout the repository being searched.

## Integrity and update policy

`scripts/generate-formula.py` selects the highest non-draft, non-prerelease
`vX.Y.Z` release at or after `v0.2.0`. It refuses to generate a formula when
any of the six archives, `install.sh`, `install.ps1`, or `checksums.txt` is
missing. It downloads each required payload and compares its SHA-256 with the
release checksum before writing the formula. Invalid versions, duplicate or
malformed checksum entries, and a checksum mismatch stop the update.

The hourly workflow and `workflow_dispatch` both produce a candidate formula
first. Native Homebrew jobs then install the candidate and run its formula
test on `ubuntu-24.04`, `ubuntu-24.04-arm`, `macos-15-intel`, and `macos-15`.
Only after every candidate check succeeds does the workflow use its own
`GITHUB_TOKEN` to commit a changed formula. A current formula is a no-op, so
rerunning the updater is idempotent.

`Formula/git-rg.rb` is generated. Make source changes in the generator rather
than hand-editing the generated version, and review the candidate diff before
merging changes. The tap intentionally does not publish Windows packages;
Windows users should use the Scoop bucket or the Release PowerShell installer.

## Local generation

From the root of this tap, with Python 3:

```sh
python3 scripts/generate-formula.py --output Formula/git-rg.rb
```

The script prints the selected release tag on stdout and diagnostics on
stderr. It needs network access to the public GitHub API and Release assets.
When `GITHUB_TOKEN` is present, it is used only in memory as a Bearer
`Authorization` header for those GitHub requests; it is never printed or
persisted. Without a token, public GitHub API rate limits still apply.

## License

The formula, generator, workflow, and documentation in this bucket are
licensed under [MIT](LICENSE).
