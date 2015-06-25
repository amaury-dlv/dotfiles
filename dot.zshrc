#
# OPTIONS
#

setopt hist_ignore_all_dups
setopt hist_reduce_blanks
setopt append_history
setopt extended_history
setopt inc_append_history

#
# ENV
#

export LC_ALL=C
export EDITOR=vim
export PAGER=less
export TERM=xterm-256color

# History
export HISTSIZE=10000
export SAVEHIST=10000
export HISTFILE=~/.zshhistory

# Path
# use gnu tools on osx
PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
export PATH="/opt/local/bin/:${PATH}"
export PATH="${HOME}/bin/:${PATH}"
export PATH="/usr/local/bin/:${PATH}"

#
# ALIASES
#

alias ls='ls -h --color=auto --group-directories-first'
alias ll='ls -l --color=auto --group-directories-first'
alias cp='cp -v'
alias mv='mv -v'
alias rm='rm -v'
alias j='jobs'
alias z='zlock -immed'

#
# BINDS
#

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

#
# PROMPT
#

autoload -Uz colors && colors
autoload -Uz promptinit && promptinit

S=%{$reset_color%}
if [[ $UID != 0  ]]; then
        C=%{$fg[blue]%} # user
else
        C=%{$fg[red]%} # root
fi
PSYMB="%(!.${C}# ${S}.${C} $ ${S})"
JPROMPT="${C}${S}"
PROMPT="${PSYMB}"
PPROMPT="${C}[${S}%~${C}]${S}"
RPROMPT="${JPROMPT}${PPROMPT}"

#
# COMPLETION
#

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
