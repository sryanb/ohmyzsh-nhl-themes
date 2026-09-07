#!/usr/bin/env python3
"""Render nhl/previews/*.png from every theme and rewrite the Themes table in README.md.

Needs ImageMagick (`magick`) and a Nerd Font; override the font with PREVIEW_FONT=/path/to.ttf.
"""
import re, subprocess, pathlib, os, tempfile
ROOT = pathlib.Path(__file__).resolve().parent.parent
FONT = os.environ.get("PREVIEW_FONT", os.path.expanduser("~/Library/Fonts/JetBrainsMonoNerdFontMono-Regular.ttf"))
HOCKEY = os.path.realpath(tempfile.mkdtemp()) + "/hockey"
os.mkdir(HOCKEY)
subprocess.run(["git", "init", "-q", "-b", "main"], cwd=HOCKEY, check=True)
subprocess.run(["git", "-c", "user.name=x", "-c", "user.email=x@x", "commit", "-q", "--allow-empty", "-m", "init"], cwd=HOCKEY, check=True)
PT, CELL, H, BASE, PAD = 28, 17.1, 50, 35, 10
DEF_FG, DEF_BG = "#d0d0d0", "#1e1e1e"

def x256(n):
    base = ["#000000","#800000","#008000","#808000","#000080","#800080","#008080","#c0c0c0",
            "#808080","#ff0000","#00ff00","#ffff00","#0000ff","#ff00ff","#00ffff","#ffffff"]
    if n < 16: return base[n]
    if n < 232:
        n -= 16; r, g, b = n // 36, (n // 6) % 6, n % 6
        v = lambda i: 0 if i == 0 else 55 + i * 40
        return "#%02x%02x%02x" % (v(r), v(g), v(b))
    v = 8 + (n - 232) * 10
    return "#%02x%02x%02x" % (v, v, v)

def runs(s):
    fg = bg = None; out = []
    for tok in re.split(r"(\x1b\[[\d;]*m)", s):
        if not tok: continue
        if tok.startswith("\x1b"):
            c = [int(x or 0) for x in tok[2:-1].split(";")]
            i = 0
            while i < len(c):
                n = c[i]
                if n == 0: fg = bg = None
                elif n == 39: fg = None
                elif n == 49: bg = None
                elif n in (38, 48) and c[i+1] == 5:
                    (fg, bg) = (x256(c[i+2]), bg) if n == 38 else (fg, x256(c[i+2])); i += 2
                elif 30 <= n <= 37: fg = x256(n - 30)
                elif 40 <= n <= 47: bg = x256(n - 40)
                elif 90 <= n <= 97: fg = x256(n - 90 + 8)
                elif 100 <= n <= 107: bg = x256(n - 100 + 8)
                i += 1
        else:
            out.append((tok, fg, bg))
    return out

def esc(t): return t.replace("\\", "\\\\").replace("'", "\\'")

out_dir = ROOT / "nhl/previews"; out_dir.mkdir(exist_ok=True)
rows = []
for f in sorted(ROOT.glob("nhl/*/*.zsh-theme")):
    ansi = subprocess.run(["zsh", "-c", 'parse_git_dirty(){}; source "$1"; print -P "$(build_prompt)"', "_", str(f)],
                          cwd=HOCKEY, capture_output=True, text=True).stdout.rstrip("\n")
    ansi = ansi.replace(HOCKEY, "~/hockey").replace(os.environ["USER"], "fan")
    rs = runs(ansi)
    ncell = sum(len(t) for t, _, _ in rs)
    W = int(PAD * 2 + ncell * CELL)
    args = ["magick", "-size", f"{W}x{H}", f"xc:{DEF_BG}", "-font", FONT, "-pointsize", str(PT)]
    x = PAD
    for t, fg, bg in rs:
        w = len(t) * CELL
        if bg: args += ["-fill", bg, "-draw", f"rectangle {x:.1f},0 {x+w:.1f},{H}"]
        args += ["-fill", fg or DEF_FG, "-draw", f"text {x:.1f},{BASE} '{esc(t)}'"]
        x += w
    png = out_dir / (f.stem + ".png")
    args.append(str(png))
    subprocess.run(args, check=True)
    name = re.match(r"# (.*?) Theme", f.read_text()).group(1)
    rows.append(f"| {name} | `{f.relative_to(ROOT)}` | ![{name}](nhl/previews/{png.name}) |")

section = "## Themes\n\nRendered with JetBrains Mono Nerd Font on a dark background.\n\n| Team | File | Preview |\n|---|---|---|\n" + "\n".join(rows) + "\n\n"
readme = ROOT / "README.md"; txt = readme.read_text()
txt = re.sub(r"## Themes\n.*?(?=## Installation)", "", txt, flags=re.S)
readme.write_text(txt.replace("## Installation", section + "## Installation", 1))
print(len(rows), "previews")
