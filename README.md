# Dotfiles

Git-native dotfiles manager ([yarlson/lnk](https://github.com/yarlson/lnk)). Moves files into a Git repo (`~/.config/lnk`, override with `LNK_HOME`/`XDG_CONFIG_HOME`) and symlinks them back.

## Install lnk

```bash
curl -sSL https://raw.githubusercontent.com/yarlson/lnk/main/install.sh | bash
```

## Dotfiles Layout

```
~/.config/lnk/
├── .lnk                 # tracked common files
├── .lnk.work            # tracked work-specific files
├── .vimrc               # common
├── .gitconfig           # common
└── work.lnk/            # host-specific storage
    └── .ssh/config
```

## New machine setup

```bash
lnk init -r git@github.com:you/dotfiles.git   # clone + run bootstrap.sh
lnk pull                                      # pull & restore symlinks
lnk pull --host work                          # pull host-specific config
```

## Commands

| Command | What it does |
| --- | --- |
| `init [-r url] [--force] [--no-bootstrap]` | Create/clone repo (runs `bootstrap.sh` on clone) |
| `add [--host H] [--recursive] [--dry-run] <files>` | Track files (move to repo + symlink) |
| `rm [--host H] [--force] <file>` | Untrack and restore; `--force` = cleanup only, no restore |
| `list [--host H] [--all]` | Show tracked files |
| `status` | Sync status (works without remote) |
| `diff [--quiet]` | Uncommitted changes |
| `push [msg]` | Stage, commit, push |
| `pull [--host H]` | Pull and restore symlinks |
| `doctor [--host H] [--dry-run]` | Fix broken symlinks / stale entries |
| `bootstrap` | Run `bootstrap.sh` manually |

**Note:** when restoring, an existing real file at the target is renamed to `<path>.lnk-backup`.
