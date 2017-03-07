# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=/home/balamurugan/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="robbyrussell"

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
plugins=(git extract common-aliases z)

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
alias e=extract
alias c=colorize

DISABLE_AUTO_TITLE="true"
tt () {
    echo -e "\033];$@\007"
}

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

MARKER_KEY_MARK='\C-d'
[[ -s "$HOME/.local/share/marker/marker.sh" ]] && source "$HOME/.local/share/marker/marker.sh"

box() {
  curl http://roles.corp.yahoo.com/roles/v1/range/@$1.arya.main.$2\?output\=json -s | sed "s/\(\[{\"bases\":\[[^]]*],\"members\"\:\[\)\([^]]*\)\(.*\)/\2/g"|sed "s/\"//g"| sed -e 's/,/\'$'\n/g'
}

roles() {
  curl -s http://roles.corp.yahoo.com/roles/v1/namespaces/$1/roles | grep "<role\ " | sed "s/^.*name=\"\([^\"]*\)\".*/\1/g"
}

_box() {
  reply=( `cat ~/.rolesdb_namespaces ` )
}


compctl -K _box box
compctl -K _box roles

function refreshns {
  curl http://roles.corp.yahoo.com/roles/v1/namespaces -s | grep "namespace\ name"| sed "s/^[^\"]*\"*//g"|sed "s/\".*//g" > ~/.rolesdb_namespaces
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

