# Env
export EDITOR=vim
export PAGER=less
export LESS="-FRX"

# History
setopt hist_ignore_all_dups
setopt hist_reduce_blanks
setopt append_history
setopt extended_history
setopt inc_append_history
export HISTSIZE=10000
export SAVEHIST=10000
export HISTFILE=~/.zshhistory

# Path
export PATH="/opt/local/bin/:${PATH}"
export PATH="$(npm config get prefix)/bin:${PATH}"
export PATH="${HOME}/.local/bin/:${PATH}"
export PATH="${HOME}/bin/:${PATH}"
export PATH="${HOME}/dotfiles/bin/:${PATH}"
export PATH="${HOME}/f/homebrew/bin/:${PATH}"
export PATH="/usr/local/bin/:${PATH}"

# ALIASES
alias ls='eza --group-directories-first'
alias ll='eza -l --group-directories-first'
alias cp='cp -v'
alias mv='mv -v'
alias rm='rm -v'
alias j='jobs'
#alias z='zlock -immed'
alias p='pbpaste'
alias c='pbcopy'

alias q='cd ~/f/vfx'
alias rb='git checkout -b amaury/PR-$(current_radar)'
alias jl='jj log'
alias jr='jj b set amaury/PR-$(current_radar)'

# BINDS
bindkey -e # emacs binds
bindkey "\e[3~" delete-char # delete

# {alt,ESC}-BS to delete last part from directory name
slash-backward-kill-word() {
        local WORDCHARS="${WORDCHARS:s@/@}"
        zle backward-kill-word
}
zle -N slash-backward-kill-word
bindkey '\e^?' slash-backward-kill-word

# {alt,ESC}-e to edit command-line in editor
autoload edit-command-line
zle -N edit-command-line
bindkey '\ee' edit-command-line

# PROMPT
autoload -Uz colors && colors
autoload -Uz promptinit && promptinit

S=%{$reset_color%}
if [[ $UID != 0  ]]; then
        C=%{$fg[blue]%} # user
else
        C=%{$fg[red]%} # root
fi
PROMPT="${C} $ ${S}"
RPROMPT="${C}[${S}%~${C}]${S}"

# COMPLETION
autoload -Uz compinit
compinit -i

zstyle ':completion:*' completer _expand _complete _approximate
zstyle ':completion:*' file-sort name
zstyle ':completion:*' ignore-parents parent pwd
zstyle ':completion:*:functions' ignored-patterns '_*'
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z} m:{a-zA-Z}={A-Za-z}' 'l:|=* r:|=*' 'r:|[._-]=* r:|=*'
zstyle ':completion:*' menu select=1
zstyle ':completion:*' original true
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*:approximate:*' max-errors par 'reply=( $(( ($#PREFIX+$#SUFFIX)/3 )) numeric )'
zstyle ':completion:*:expand:*' tag-order all-expansions
zstyle ':completion:*:processes' command 'ps -au$USER' # kill completion

# fzf
source <(fzf --zsh)

# zoxide
eval "$(zoxide init zsh)"


