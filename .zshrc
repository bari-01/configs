#plugins=(
#  git
#)
#
#ZSH_THEME="agnoster" # (this is one of the fancy ones)
## see https://github.com/ohmyzsh/ohmyzsh/wiki/Themes#agnoster

### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

### End of Zinit's installer chunk

# Load core OMZ plugins
zinit light zsh-users/zsh-autosuggestions
zinit light marlonrichert/zsh-autocomplete

#zstyle ':autocomplete:*' accept-exact '*(N)'
#zstyle ':autocomplete:*' auto-select yeso
#zstyle ':autocomplete:*' insert-unambiguous yes
bindkey -M menuselect '^M' .accept-line

bindkey -M menuselect  '^[[D' .backward-char  '^[OD' .backward-char
bindkey -M menuselect  '^[[C'  .forward-char  '^[OC'  .forward-char
bindkey              '^I' menu-select
bindkey "$terminfo[kcbt]" menu-select

# Optional: lazy load git prompt plugin
#zinit ice atload"echo 'Git plugin loaded'" lucid
zinit snippet OMZP::git

# 1. Enable prompt substitution (crucial for dynamic prompts)
setopt promptsubst

# 2. Load necessary OMZ libraries (themes usually need these)
zinit snippet OMZL::git.zsh
zinit snippet OMZL::prompt_info_functions.zsh

# 3. Load your chosen theme (e.g., robbyrussell)
zinit snippet OMZT::agnoster
#zinit ice wait"!" atload"_zsh_highlight"
#zinit load zsh-users/zsh-syntax-highlighting
zinit light zdharma-continuum/fast-syntax-highlighting
alias ls="eza -a --icons always"

# History
HISTFILE=$HOME/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory sharehistory inc_append_history hist_ignore_dups hist_ignore_space

# Keybindings
#bindkey -e
bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line
bindkey "^[[3~" delete-char
