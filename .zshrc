# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000000
SAVEHIST=1000000
bindkey -e
# End of lines configured by zsh-newuser-install

setopt HIST_VERIFY
#setopt SHARE_HISTORY

setopt EXTENDED_HISTORY 

setopt HIST_IGNORE_DUPS
setopt HIST_REDUCE_BLANKS

setopt NO_HIST_BEEP

setopt NO_BEEP


if [[ -r ~/.aliasrc ]]; then 
	source ~/.aliasrc
fi

path+=('/home/paulw/.screenlayout' '/home/paulw/.local/bin')
export PATH

# Not all servers have terminfo for rxvt-256color. :<
if [ "${TERM}" = 'rxvt-256color' ] && ! [ -f '/usr/share/terminfo/r/rxvt-256color' ] && ! [ -f '/lib/terminfo/r/rxvt-256color' ] && ! [ -f "${HOME}/.terminfo/r/rxvt-256color" ]; then
    export TERM='rxvt-unicode'
fi

alias -g latest='*(om[1])'

fpath=(~/.my_zsh_functions "${fpath[@]}")
autoload -Uz compinit colors
colors
# autocompletion
compinit



export TMP="$HOME/tmp"
export TEMP="$TMP"
export TMPDIR="$TMP"


# Fancy cd that can cd into parent directory, if trying to cd into file.
# useful with ^F fuzzy searcher.
cd() {
    if (( $+2 )); then
        builtin cd "$@"
        return 0
    fi

    if [ -f "$1" ]; then
        echo "${yellow}cd ${1:h}${NC}" >&2
        builtin cd "${1:h}"
    else
        builtin cd "${@}"
    fi
}

# Control-x-e to open current line in $EDITOR, awesome when writting functions or editing multiline commands.
autoload -U edit-command-line
zle -N edit-command-line
bindkey '^x^e' edit-command-line

confirm() {
    local answer
    echo -ne "zsh: sure you want to run '${YELLOW}$*${NC}' [yN]? "
    read -q answer
        echo
    if [[ "${answer}" =~ ^[Yy]$ ]]; then
        command "${@}"
    else
        return 1
    fi
}

confirm_wrapper() {
    if [ "$1" = '--root' ]; then
        local as_root='true'
        shift
    fi

    local prefix=''

    if [ "${as_root}" = 'true' ] && [ "${USER}" != 'root' ]; then
        prefix="sudo"
    fi
    confirm ${prefix} "$@"
}

poweroff() { confirm_wrapper --root $0 "$@"; }
reboot() { confirm_wrapper --root $0 "$@"; }
hibernate() { confirm_wrapper --root $0 "$@"; }

startx() {
    exec =startx
}


# Prevent insert key from changing input mode.
# (switch to Emacs mode)
bindkey -e

# Control-x-e to open current line in $EDITOR, awesome when writting functions or editing multiline commands.
autoload -U edit-command-line
zle -N edit-command-line
bindkey '^x^e' edit-command-line

# Completion.
autoload -Uz compinit
compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' completer _expand _complete _ignored _approximate
zstyle ':completion:*' menu select=2
zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'
zstyle ':completion::complete:*' use-cache 1
zstyle ':completion:*:descriptions' format '%U%F{cyan}%d%f%u'

# If running as root and nice >0, renice to 0.
if [ "$USER" = 'root' ] && [ "$(cut -d ' ' -f 19 /proc/$$/stat)" -gt 0 ]; then
    renice -n 0 -p "$$" && echo "# Adjusted nice level for current shell to 0."
fi

over_ssh() {
    if [ -n "${SSH_CLIENT}" ]; then
        return 0
    else
        return 1
    fi
}

# Fancy prompt.
if over_ssh; then
    prompt_is_ssh='%F{blue}[%F{253}SSH%F{blue}] '
else
    unset prompt_is_ssh
fi

case $USER in
    root)
        PROMPT='%B%F{cyan}%m%k %(?..%F{blue}[%F{253}%?%F{blue}] )${prompt_is_ssh}%B%F{blue}%1~${git_prompt}%F{blue} %# %b%f%k'
    ;;

    *)  
	PS1="%~ ${prompt_is_ssh}%#"
    ;;
esac

# Keep history of `cd` as in with `pushd` and make `cd -<TAB>` work.
DIRSTACKSIZE=16
setopt auto_pushd
setopt pushd_ignore_dups
setopt pushd_minus

# Ignore lines prefixed with '#'.
setopt interactivecomments

# Ignore duplicate in history.
setopt hist_ignore_dups

# Nobody need flow control anymore. Troublesome feature.
#stty -ixon
setopt noflowcontrol

# Ensure that / is added after tab complation to directories.
# without disabling it, $LBUFFER does not have the slash at the end
# and it's required for _append_path_to_buffer thing..
#setopt AUTO_PARAM_SLASH
#unsetopt AUTO_REMOVE_SLASH
_select_path_with_fzy() {
    (
        if [ "$1" != '.' ]; then
            if ! [ -d $~1 ]; then
                echo -e "${yellow}The $1 is not a directory.${NC}"  >&2
                return
            fi
            cd $~1
        fi

        find -L . \( -type d -printf "%p/\n" , -type f -print \) 2>/dev/null | cut -c 3- | sort | fzy
    )
}

_append_path_to_buffer() {
    local selected_path

    if ! command -v fzy >/dev/null 2>&1; then
        echo 'No fzy binary found in $PATH.'
        return 1
    fi
    echo
    print -nr "${zle_bracketed_paste[2]}" >/dev/tty
    {
        if [ "${LBUFFER[-1]}" = '/' ]; then
            search_in="${LBUFFER##*[$'\t' ]}"
        else
            search_in='.'
        fi

        selected_path="$(_select_path_with_fzy "${search_in}")"
    } always {
        print -nr "${zle_bracketed_paste[1]}" >/dev/tty
    }
    if [ "${selected_path}" ]; then
        if [[ "${LBUFFER[-1]}" =~ [[:alnum:]] ]]; then
            # if last character is a word character, insert space.
            # before inserting selected path. Useful when one's lazy 
            # and use 'vim^F', yet works okay with 'cmd foo=^F'.
            LBUFFER+=" "
        fi
        LBUFFER+="${(q)selected_path}"
    fi
    zle reset-prompt
}
zle -N _append_path_to_buffer
bindkey "^F" _append_path_to_buffer

_history_search_with_fzy() {
    local selected_history_entry

    if ! command -v fzy >/dev/null 2>&1; then
        echo 'No fzy binary found in $PATH.'
        return 1
    fi

    if ! command -v awk >/dev/null 2>&1; then
        echo 'No awk binary found in $PATH.'
        return 1
    fi
    echo

    print -nr "${zle_bracketed_paste[2]}" >/dev/tty
    {
        # The awk is used to filter out duplicates, keeping the most 
        # recent entries, while not re-ordering the history list.
        selected_history_entry="$(fc -nrl 1 | awk '!v[$0]++' | fzy)"
    } always {
        print -nr "${zle_bracketed_paste[1]}" >/dev/tty
    }
    if [ "${selected_history_entry}" ]; then
        BUFFER="${selected_history_entry}"
        CURSOR="${#BUFFER}"
    fi
    zle reset-prompt
}
zle -N _history_search_with_fzy
bindkey "^T" _history_search_with_fzy

# Aliases
alias cp='cp -iv'
alias rcp='rsync -v --progress'
alias rmv='rsync -v --progress --remove-source-files'
alias mv='mv -iv'
alias rm='rm -iv'
alias rmdir='rmdir -v'
alias ln='ln -v'
alias chmod="chmod -c"
alias chown="chown -c"
alias mkdir="mkdir -v"

if command -v colordiff > /dev/null 2>&1; then
    alias diff="colordiff -Nuar"
else
    alias diff="diff -Nuar"
fi

alias grep='grep --colour=auto'
alias egrep='egrep --colour=auto'
alias ls='ls --color=auto --human-readable --group-directories-first --classify'
alias ll='ls --color=auto --human-readable --group-directories-first --classify -l'
alias lla='ls --color=auto --human-readable --group-directories-first --classify -la'

autoload -Uz glm extract mlrsync
glm 2>/dev/null >/dev/null

# Replaced with _history_search_with_fzy
bindkey "^R" history-incremental-pattern-search-backward 
bindkey "^S" history-incremental-pattern-search-forward

if [ -f ~/.alert ]; then echo '>>> Check ~/.alert'; fi

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
bindkey "^[[B" history-substring-search-down
bindkey "^[[A" history-substring-search-up

source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/git/git.plugin.zsh
source /usr/share/zsh/plugins/git-extras/git-extras.plugin.zsh
source /usr/share/zsh/plugins/command-not-found/command-not-found.plugin.zsh
source /usr/share/zsh/plugins/zsh-you-should-use/you-should-use.plugin.zsh
source /usr/share/zsh/plugins/z/z.plugin.zsh
source /usr/share/zsh/plugins/liquidprompt/liquidprompt.plugin.zsh
#source /usr/share/zsh/plugins/git-prompt/git-prompt.plugin.zsh
#PS1="%~ $(git_super_status)%#"
#RPS1="%F{red}%(?..(%?%))%F{reset}"
#PS2='%_> '
#PS1="%~ %#"


# make webstorm work
export _JAVA_AWT_WM_NONREPARENTING=1

source ~/.workrc
