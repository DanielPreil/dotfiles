[ -f "$HOME/.zshrc.local" ] && source "$HOME/.zshrc.local"

# Oh My Zsh
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(git)

source "$ZSH/oh-my-zsh.sh"

# Powerlevel10k config
# Zoxide
if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init zsh)"
fi

# >>> terminal recovery setup >>>

# Homebrew
if [ -x /opt/homebrew/bin/brew ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Oh My Zsh + Powerlevel10k
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"

# Fontos: zsh-syntax-highlighting NEM itt van, hanem legalul kézzel source-olva,
# mert annak kell az egyik legutolsónak betöltődnie.
plugins=(
  git
  zsh-autosuggestions
  zsh-completions
  history-substring-search
  you-should-use
)

source "$ZSH/oh-my-zsh.sh"

# Zoxide - `z` command
if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init zsh)"
fi

# fzf - Ctrl+R history search + completions
if command -v brew >/dev/null 2>&1; then
  FZF_BASE="$(brew --prefix)/opt/fzf/shell"

  if [ -f "$FZF_BASE/key-bindings.zsh" ]; then
    source "$FZF_BASE/key-bindings.zsh"
  fi

  if [ -f "$FZF_BASE/completion.zsh" ]; then
    source "$FZF_BASE/completion.zsh"
  fi

  bindkey '^R' fzf-history-widget 2>/dev/null || true
fi

# History substring search - fel/le nyíl keres az előzményekben
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# Hasznos aliasok
alias c="clear"
alias ..="cd .."
alias ...="cd ../.."
alias ll="ls -la"
alias la="ls -A"

# Ne aliasold a grep-et rg-re, mert elront grep -E típusú parancsokat.
# Használd külön az rg parancsot.
unalias grep 2>/dev/null || true

if command -v eza >/dev/null 2>&1; then
  alias ls="eza --icons"
  alias ll="eza -la --icons --git"
  alias tree="eza --tree --icons"
fi

if command -v bat >/dev/null 2>&1; then
  alias cat="bat"
fi

# pnpm
export PNPM_HOME="$HOME/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# Rust/Cargo
if [ -d "$HOME/.cargo/bin" ]; then
  export PATH="$HOME/.cargo/bin:$PATH"
fi

# Powerlevel10k config
[[ ! -f "$HOME/.p10k.zsh" ]] || source "$HOME/.p10k.zsh"

# Syntax highlighting - maradjon a legvégén
if [ -f "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]; then
  source "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi

# <<< terminal recovery setup <<<
