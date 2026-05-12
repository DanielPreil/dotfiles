if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
DISABLE_AUTO_UPDATE="true"

plugins=(
  git
  zsh-autosuggestions
  zsh-completions
  history-substring-search
)

source "$ZSH/oh-my-zsh.sh"

if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init zsh)"
fi

FZF_BASE="/opt/homebrew/opt/fzf/shell"
if [ -f "$FZF_BASE/key-bindings.zsh" ]; then
  source "$FZF_BASE/key-bindings.zsh"
fi
if [ -f "$FZF_BASE/completion.zsh" ]; then
  source "$FZF_BASE/completion.zsh"
fi
bindkey '^R' fzf-history-widget 2>/dev/null || true

bindkey '^[[A' history-substring-search-up 2>/dev/null || true
bindkey '^[[B' history-substring-search-down 2>/dev/null || true

alias c="clear"
alias ..="cd .."
alias ...="cd ../.."
alias ll="ls -la"
alias la="ls -A"

unalias grep 2>/dev/null || true

if command -v eza >/dev/null 2>&1; then
  alias ls="eza --icons"
  alias ll="eza -la --icons --git"
  alias tree="eza --tree --icons"
fi

if command -v bat >/dev/null 2>&1; then
  alias cat="bat"
fi

export PNPM_HOME="$HOME/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

if [ -f "$HOME/.vite-plus/env" ]; then
  source "$HOME/.vite-plus/env"
fi

[[ ! -f "$HOME/.p10k.zsh" ]] || source "$HOME/.p10k.zsh"

if [ -f "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]; then
  source "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi
