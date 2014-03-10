## .zshrc by Jeremy Betz last update 2013/08

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd nomatch
unsetopt appendhistory extendedglob
# End of lines configured by zsh-newuser-install

#Ignore duplicate lines or lines that start with a space in history
setopt hist_ignore_all_dups hist_ignore_space
HISTCONTROL=ignoreboth
#No history for lines starting with spaces

# emacs style keybindings
bindkey -e

# set up colors for directory tab-completions
eval `dircolors -b`

# The following lines were added by compinstall

zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' verbose true
zstyle :compinstall filename '$HOME/.zshrc'

autoload -U compinit promptinit
compinit
promptinit
# End of lines added by compinstall

# environment
export EDITOR='emacs'
export PAGER='/usr/bin/most'
export MANPAGER=$PAGER
#Chromium default opener (Idea from Mark Somerville)
export BROWSER="kde-open"
export TZ=/etc/localtime
# colors
autoload colors zsh/terminfo
if [[ "$terminfo[colors]" -ge 8 ]]; then
    colors
fi
for color in RED GREEN YELLOW BLUE MAGENTA CYAN WHITE; do
    eval PR_$color='%{$terminfo[bold]$fg[${(L)color}]%}'
    eval PR_LIGHT_$color='%{$fg[${(L)color}]%}'
    (( count = $count + 1 ))
done
PR_NO_COLOR="%{$terminfo[sgr0]%}"

# line drawing characters
typeset -A altchar
set -A altchar ${(s..)terminfo[acsc]}
PR_SET_CHARSET="%{$terminfo[enacs]%}"
PR_SHIFT_IN="%{$terminfo[smacs]%}"
PR_SHIFT_OUT="%{$terminfo[rmacs]%}"
PR_ULCORNER=${altchar[l]:--}
PR_LLCORNER=${altchar[m]:--}
PR_URCORNER=${altchar[k]:--}
PR_LRCORNER=${altchar[j]:--}
PR_HBAR=${altchar[q]:--}

#Version Control Info (vcs)
autoload -Uz vcs_info && vcs_info

zstyle ':vcs_info:*' enable git hg svn

_vcs_fmt_action="%b %a"
_vcs_fmt_branch="%b"
_vcs_fmt_type="%s"

zstyle ':vcs_info:git:*' actionformats \
    $_vcs_fmt_action $_vcs_fmt_type
zstyle ':vcs_info:git:*' formats \
    $_vcs_fmt_branch $_vcs_fmt_type

# set up variables for prompt
precmd () {
    vcs_info
}


##Misc Items

# default to gnu utils on non-linux platforms
if [[ $OSTYPE != linux* ]]
then
    alias ls='gls'
    alias diff='gdiff'
fi

# prompt definitions
() {
    setopt prompt_subst

    PS1='$PR_BLUE$PR_SHIFT_IN$PR_ULCORNER$PR_SHIFT_OUT(\
$PR_GREEN%(!.$PR_RED.)%n@%m:%l\
$PR_BLUE)$PR_SHIFT_IN$PR_HBAR$PR_SHIFT_OUT(\
$PR_MAGENTA%~$PR_BLUE)\

$PR_SHIFT_IN$PR_LLCORNER$PR_SHIFT_OUT(\
$PR_YELLOW%D{%H:%M}$PR_BLUE) %(!.$PR_RED.$PR_GREEN)%#$PR_NO_COLOR '

    RPROMPT='$PR_BLUE($PR_RED$vcs_info_msg_1_ $PR_YELLOW$vcs_info_msg_0_\
$PR_BLUE)$PR_SHIFT_IN$PR_LRCORNER$PR_SHIFT_OUT$PR_NO_COLOR'
}

#Terminal aliases
alias ls='ls --color=auto'
alias grep='grep --colour=auto -n'
alias c='clear'

##Bashrc stuff

# Put your fun stuffhere.
alias lock="xset dpms force off & xscreensaver-command -lock"
alias mon-off="xset dpms force off"

#Matlab fix (old)
#export MATLAB_JAVA="/etc/java-config-2/current-system-vm/jre/"

#Keybindings (from arch wiki)
bindkey "\e[1~" beginning-of-line
bindkey "\e[4~" end-of-line
bindkey "\e[5~" beginning-of-history
bindkey "\e[6~" end-of-history
bindkey "\e[3~" delete-char
bindkey "\e[2~" quoted-insert
bindkey "\e[5C" forward-word
bindkey "\eOc" emacs-forward-word
bindkey "\e[5D" backward-word
bindkey "\eOd" emacs-backward-word
bindkey "\e\e[C" forward-word
bindkey "\e\e[D" backward-word
# for rxvt
bindkey "\e[8~" end-of-line
bindkey "\e[7~" beginning-of-line
# for non RH/Debian xterm, can't hurt for RH/Debian xterm
bindkey "\eOH" beginning-of-line
bindkey "\eOF" end-of-line
# for freebsd console
bindkey "\e[H" beginning-of-line
bindkey "\e[F" end-of-line

#Jeremy console
bindkey "\e[1;5D" backward-word
bindkey "\e[1;5C" forward-word

#Miles custom
#Laptop power
#alias battery-percent="cat /sys/devices/platform/smapi/BAT0/remaining_percent"
#alias battery-time="cat /sys/devices/platform/smapi/BAT0/remaining_running_time"

# SSH Keychain
#eval `keychain --eval`
#alias keychain-local="keychain ~/.ssh/id_rsa"
#alias keychain-clear="keychain --clear"
