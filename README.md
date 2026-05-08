# Dotfiles

Személyes macOS fejlesztői környezetem konfigurációi.
Fókusz: **AstroNvim (v5)** + **WezTerm** + **Zsh**.

## Fontos

Ez a repó személyes használatra készült. Több beállítás gépfüggő (pl. `/Users/preildaniel/...` PATH-ok), ezért más gépen várhatóan igazítani kell.

## Tartalom

- `nvim/`: AstroNvim-alapú, jelentősen módosított Neovim setup
- `wezterm.lua`: WezTerm tab- és navigációs workflow
- `.zshrc`: Oh My Zsh + Powerlevel10k + fejlesztői környezet PATH-ok

## Előfeltételek

- `git`
- `zsh`
- `neovim` (0.10+ ajánlott)
- `wezterm`
- Nerd Font támogatás (a config `Lilex` fontot használ)
- ajánlott: `fzf`, `zoxide`, `ripgrep`

## Telepítés (biztonságos, backupos)

```bash
# 1) klónozás
git clone https://github.com/DanielPreil/dotfiles.git ~/dotfiles
cd ~/dotfiles

# 2) backup (ha már léteznek fájlok)
[ -e ~/.config/nvim ] && mv ~/.config/nvim ~/.config/nvim.bak
[ -e ~/.wezterm.lua ] && mv ~/.wezterm.lua ~/.wezterm.lua.bak
[ -e ~/.zshrc ] && mv ~/.zshrc ~/.zshrc.bak

# 3) symlinkek
mkdir -p ~/.config
ln -sfn ~/dotfiles/nvim ~/.config/nvim
ln -sfn ~/dotfiles/wezterm.lua ~/.wezterm.lua
ln -sfn ~/dotfiles/.zshrc ~/.zshrc
```

## Frissítés

```bash
cd ~/dotfiles
git pull
```

Neovimben frissítés után:

```vim
:Lazy sync
```

## Mit módosítottam a default AstroNvimhez képest

- gyors görgetés/navigáció: `accelerated-jk` (`Alt+j`, `Alt+k`)
- Harpoon 2 workflow: gyors fájlváltás (`<leader>a`, `<leader>A`, `<leader>1..4`)
- LSP `gd`: picker helyett közvetlen ugrás definícióra
- format-on-save aktív (CSS/SCSS kivétellel)
- előtelepített LSP/tool lista Masonnel (JavaScript/TypeScript fókusz, React/Next.js és Vue projektekhez, Tailwinddel, plusz Lua környezettel)
- egyedi UI irány: `rose-pine`, transzparens felületek, testreszabott highlightok
- `noice` + `nvim-notify` üzenetkezelés
- produktivitás pluginok: `vim-visual-multi`, `undotree`, `grug-far`, `gitsigns`, `todo-comments`, `nvim-surround`
- mentéskor nézetpozíció visszaállítása (`polish.lua`)

## WezTerm workflow

- `Cmd+h` / `Cmd+l`: tab váltás
- `Alt+h` / `Alt+l`: tab mozgatás
- `Cmd+r`: tab átnevezés
- induláskor `dev` tab + maximalizált ablak
- `Option+j` / `Option+k` átadása Neovimnek (`Meta+j` / `Meta+k`)

## Zsh röviden

- Oh My Zsh + Powerlevel10k
- `zsh-autosuggestions`, `zsh-syntax-highlighting`
- `zoxide` egyedi `z()` wrapper
- `fzf` Tab kiválasztás (`--bind=tab:accept`)
- több runtime/tool PATH (Node 22, pnpm, bun, PostgreSQL, herd-lite)

## Karbantartás

- pluginverziók rögzítve: `nvim/lazy-lock.json`
- Neovim plugin frissítés után ellenőrzés: `:Lazy sync`

## Hibaelhárítás

- ikonok hibásak: ellenőrizd a Nerd Font / `Lilex` beállítást
- `Alt+j/k` nem működik: WezTerm `Option` továbbítás és Neovim mapping ellenőrzése
- első indításnál hiányzó LSP/tool: Mason csomagok telepítésének megvárása

## Megjegyzés

A README a fő workflow-t foglalja össze, nem teljes billentyűzet-referencia.

## Licenc

MIT — részletek: [LICENSE](./LICENSE)
