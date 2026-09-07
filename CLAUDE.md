# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

Sports-team-coloured Oh My Zsh prompt themes, grouped by league. Pure zsh, no build, no tests, no dependencies beyond Oh My Zsh and a Nerd Font.

## Layout

One directory per league (`nhl/` today), and one directory per team inside it, containing `<team>-current.zsh-theme` and optionally `<team>-retro.zsh-theme` (retro palette). Users copy the directory into `~/.oh-my-zsh/custom/themes/` and set `ZSH_THEME="<team>/<team>-current"`. A new league is a new top-level folder with its own `### <League>` subsection under Themes in the README.

## Architecture

Every theme file is a self-contained copy of the same agnoster-style powerline prompt. There is no shared library on purpose: each file must work standalone when copied into the Oh My Zsh themes directory.

The only parts that differ between themes are at the top of each file:

- `PRIMARY` / `SECONDARY` / `TERTIARY` / `ACCENT` — 256-colour codes with the hex source colour in a comment
- `TEAM_ICON` — a Nerd Font (or plain Unicode) codepoint

Everything below that (`prompt_segment`, `prompt_git`, `prompt_dir`, `prompt_status`, `prompt_aws`, `build_prompt`) is shared boilerplate. The segment functions take `(bg, fg, text)`; theme identity comes from which palette variable is passed to each call.

Every file must share the exact same body. The only lines allowed to differ below the palette block are the `TEAM_ICON` line, the `# Context:` comment, and the colour arguments of the four `prompt_segment` calls for user, directory, clean git, and dirty git. Check it with:

```
for f in nhl/*/*.zsh-theme; do sed -E '1,/^# Nerd Font Symbols/d; /^TEAM_ICON=/d; s/prompt_segment \$[A-Z]+ \$[A-Z]+/prompt_segment X Y/; /^# Context:/d' "$f" | md5 -q; done | sort | uniq -c
```

One hash means no drift. More than one means a file diverged; fix it by re-applying the shared body rather than patching around it.

Consequences:

- A bug fix in the shared boilerplate must be applied to every `.zsh-theme` file, not just one, and the drift check above must still report one hash afterwards.
- To add a team, copy an existing theme, change the header comment, the palette block, `TEAM_ICON`, and the `prompt_segment` colour arguments.

## Checking a change

```
ZSH_THEME="oilers/oilers-current" zsh -i
```

or from an existing shell, `source <team>/<team>-current.zsh-theme` and press Enter to redraw the prompt. Test inside a git repo with a dirty tree to exercise `prompt_git`.

## Previews

`nhl/previews/*.png` and the Themes table in `README.md` are generated, not hand-drawn. Regenerate them after changing a theme: expand the prompt with `print -P "$(build_prompt)"` in a throwaway git repo and render the colour runs with ImageMagick and a Nerd Font.
