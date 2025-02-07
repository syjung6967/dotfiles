setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS

alias vi=nvim
alias vim=nvim

# Enable forward searching by remapping XON/XOFF flow control to unused control character.
[[ $- == *i* ]] && stty stop '^P'

# BSD / Mac OS style 'ls' colorization
export CLICOLOR=1

zstyle ':completion:*:*:git:*' script $HOMEBREW_PREFIX/share/zsh/site-functions/git-completion.bash
fpath=($HOME/.zsh/completion $fpath)

autoload -Uz compinit && compinit

function parse_git_branch() {
    git branch 2> /dev/null | sed -n -e 's/^\* \(.*\)/[\1]/p'
}

COLOR_DEF=$'%f'
COLOR_USR=$'%F{243}'
COLOR_DIR=$'%F{197}'
COLOR_GIT=$'%F{39}'
setopt PROMPT_SUBST
export PROMPT='${COLOR_USR}%n ${COLOR_DIR}%~ ${COLOR_GIT}$(parse_git_branch)${COLOR_DEF}$ '

function h2b() {
    num=$(echo $1 | tr '[a-z]' '[A-Z]' | sed 's/0X//')
    if [ -z "$(echo "$num" | tr -d '0123456789ABCDEF')" ]; then
        echo "obase=2; ibase=16; $num" | BC_LINE_LENGTH=65535 bc
    else
        echo "wrong input"
    fi
}

function b2h() {
    num=$(echo $1 | tr '[a-z]' '[A-Z]')
    if [ -z "$(echo "$num" | tr -d '01')" ]; then
        printf "0x"
        echo "obase=16; ibase=2; $num" | BC_LINE_LENGTH=65535 bc | tr '[A-Z]' '[a-z]'
    else
        echo "wrong input"
    fi
}

function h2d() {
    num=$(echo $1 | tr '[a-z]' '[A-Z]' | sed 's/0X//')
    if [ -z "$(echo "$num" | tr -d '0123456789ABCDEF')" ]; then
        echo "obase=10; ibase=16; $num" | BC_LINE_LENGTH=65535 bc
    else
        echo "wrong input"
    fi
}

function d2h() {
    num=$(echo $1 | tr '[a-z]' '[A-Z]')
    if [ -z "$(echo "$num" | tr -d '0123456789')" ]; then
        printf "0x"
        echo "obase=16; ibase=10; $num" | BC_LINE_LENGTH=65535 bc | tr '[A-Z]' '[a-z]'
    else
        echo "wrong input"
    fi
}

function ruler() {
    echo "|----0----|----1----|----2----|----3----|----4----|----5----|----6----|----7----|"
    echo $1
    echo "|----0----|----1----|----2----|----3----|----4----|----5----|----6----|----7----|"
}

function tree() {
    find -s $@ | sed 's%[^/]*/%  %g'
}

autoload -U +X bashcompinit && bashcompinit
alias 'dotfiles=/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# If ssh-agent is running, use its environment.
# Otherwise, start a new one manually.
# To avoid launching multiple agents, this script does not start a new agent.
if [ -e $SSH_AUTH_SOCK ]; then
    export SSH_AGENT_PID=$(pgrep -u $USER ssh-agent)
else
    eval $(ssh-agent -s)
fi

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="$HOME/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)
