# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

NHL-team-coloured Oh My Zsh prompt themes. Pure zsh, no build, no tests, no dependencies beyond Oh My Zsh and a Nerd Font.

## Layout

One directory per team under `nhl/`, containing `<team>-current.zsh-theme` and optionally `<team>-retro.zsh-theme` (retro palette). Users copy the directory into `~/.oh-my-zsh/custom/themes/` and set `ZSH_THEME="<team>/<team>-current"`.

## Architecture

Every theme file is a self-contained copy of the same agnoster-style powerline prompt. There is no shared library on purpose: each file must work standalone when copied into the Oh My Zsh themes directory.

The only parts that differ between themes are at the top of each file:

- `PRIMARY` / `SECONDARY` / `TERTIARY` / `ACCENT` — 256-colour codes with the hex source colour in a comment
- `TEAM_ICON` — a Nerd Font (or plain Unicode) codepoint

Everything below that (`prompt_segment`, `prompt_git`, `prompt_dir`, `prompt_status`, `prompt_aws`, `build_prompt`) is shared boilerplate. The segment functions take `(bg, fg, text)`; theme identity comes from which palette variable is passed to each call.

Consequences:

- A bug fix in the shared boilerplate must be applied to every `.zsh-theme` file, not just one. Use `diff` between two files to see what has drifted (some files already differ slightly in `prompt_segment` spacing and the rebase check).
- To add a team, copy an existing theme, change the header comment, the palette block, `TEAM_ICON`, and the `prompt_segment` colour arguments.

## Checking a change

```
ZSH_THEME="oilers/oilers-current" zsh -i
```

or from an existing shell, `source <team>/<team>-current.zsh-theme` and press Enter to redraw the prompt. Test inside a git repo with a dirty tree to exercise `prompt_git`.
