# Credit: https://kev.inburke.com/kevin/profiling-zsh-startup-time/

PROFILE_STARTUP=false
if [[ "$PROFILE_STARTUP" == true ]]; then
    zmodload zsh/zprof # Output load-time statistics
    # http://zsh.sourceforge.net/Doc/Release/Prompt-Expansion.html
    PS4=$'%D{%M%S%.} %N:%i> '
    exec 3>&2 2>"${XDG_CACHE_HOME:-$HOME/temp}/zsh_statup.$$"
    setopt xtrace prompt_subst
fi

# 
# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=$HOME/oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
export PER_DIRECTORY_HISTORY_TOGGLE='^T'
plugins=(git mvn extract colorize per-directory-history fasd fzf common-aliases)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
source ~/.bash_profile
alias c=colorize

DISABLE_AUTO_TITLE="true"
tt () {
    echo -e "\033];$@\007"
}

MARKER_KEY_MARK='\C-o'
MARKER_KEY_NEXT_PLACEHOLDER='\et'
[[ -s "$HOME/.local/share/marker/marker.sh" ]] && source "$HOME/.local/share/marker/marker.sh"

box() {
  curl https://roles.corp.yahoo.com:4443/roles/v1/range/@$1.arya.main.$2\?output\=json -s | sed "s/\(\[{\"bases\":\[[^]]*],\"members\"\:\[\)\([^]]*\)\(.*\)/\2/g"|sed "s/\"//g"| sed -e 's/,/\'$'\n/g'
}

roles() {
  curl -s https://roles.corp.yahoo.com:4443/roles/v1/namespaces/$1/roles | grep "<role\ " | sed "s/^.*name=\"\([^\"]*\)\".*/\1/g"
}

_box() {
  reply=( `cat ~/.rolesdb_namespaces ` )
}


compctl -K _box box
compctl -K _box roles

function refreshns {
  curl https://roles.corp.yahoo.com:4443/roles/v1/namespaces -s | grep "namespace\ name"| sed "s/^[^\"]*\"*//g"|sed "s/\".*//g" > ~/.rolesdb_namespaces
}

tailstorm () {
    host=`box $1 $2 | head -n1`
    echo "Host : " $host
    topology=`ssh $host "ls -t /home/y/var/storm/workers-artifacts/" | head -n 1`
    echo "Topology : " $topology
    hosts=`box $1 $2 | tr '\n' ' '`
    echo "Hosts : " $hosts
    ctail -m "$hosts" -f /home/y/var/storm/workers-artifacts/$topology/6700/worker.log
}

source ~/oh-my-zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh  

export SSH_AUTH_SOCK=$HOME/.yubiagent/sock

function diff {
     colordiff -u "$@" | less -RF
}

#dedup history
setopt EXTENDED_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_BEEP


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh --no-use" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Entirety of your .zshrc 

if [[ "$PROFILE_STARTUP" == true ]]; then
    zprof
    unsetopt xtrace
    exec 2>&3 3>&-
fi

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

z() {
  local dir
  dir="$(fasd -Rdl "$1" | fzf -1 -0 --no-sort +m)" && cd "${dir}" || return 1
}

export SSH_AUTH_SOCK=/Users/balamurugan/.yubiagent/sock

export SSH_AUTH_SOCK=/Users/balamurugan/.yubiagent/sock

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/balamurugan/Downloads/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/balamurugan/Downloads/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/balamurugan/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/balamurugan/Downloads/google-cloud-sdk/completion.zsh.inc'; fi
