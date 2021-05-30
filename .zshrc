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
export ZSH_DISABLE_COMPFIX=true
export ZSH=$HOME/oh-my-zsh
ZSH_THEME="powerlevel10k/powerlevel10k"
export PER_DIRECTORY_HISTORY_TOGGLE='^T'
plugins=(git mvn extract colorize per-directory-history fasd fzf common-aliases globalias vi-mode aws golang docker)
source $ZSH/oh-my-zsh.sh
bindkey '^]' vi-cmd-mode

export EDITOR='vim'

# ssh
export SSH_KEY_PATH="~/.ssh/rsa_id"

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

source ~/oh-my-zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh  


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


test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

function jj {
  local dir
  dir="$(fasd -Rdl "$1" | fzf -1 -0 --no-sort +m)" && cd "${dir}" || return 1
}
alias z=jj

# fh - repeat history
fh() {
  print -z $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | gsed -r 's/ *[0-9]*\*? *//' | gsed -r 's/\\/\\\\/g')
}

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/balamurugan/Downloads/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/balamurugan/Downloads/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/balamurugan/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/balamurugan/Downloads/google-cloud-sdk/completion.zsh.inc'; fi

source $REPOS/liftoff/ops/credentials/developer.profile
# Entirety of your .zshrc 

if [[ "$PROFILE_STARTUP" == true ]]; then
    zprof
    unsetopt xtrace
    exec 2>&3 3>&-
fi

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/Users/bchandrasekaran/.sdkman"
[[ -s "/Users/bchandrasekaran/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/bchandrasekaran/.sdkman/bin/sdkman-init.sh"
