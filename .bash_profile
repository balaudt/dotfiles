export REPOS=~/src
export BASE_DIR=~/work
export KAFKA_DIR=$BASE_DIR/kafka
export PATH="/usr/local/opt/postgresql@10/bin:$PATH":~/bin:$BASE_DIR:$KAFKA_DIR/bin:~/work/apache-maven-3.6.3/bin
export LIFTOFF_VENV_ROOT=$HOME/.venv
eval "$(pyenv init -)"
eval "$(rbenv init -)"
#Plugins PATH extension
export PATH=$PATH:/usr/local/opt/llvm/bin/:/usr/local/Cellar/cmake/3.7.1/bin/
export JAVA_HOME=/Library/Java/JavaVirtualMachines/adoptopenjdk-8.jdk/Contents/Home

#Aliases
#Git
alias gs='git status -suno'
alias gc='git commit -m'
alias gdm='git diff master..HEAD'
alias gdmf='git diff master..HEAD --name-only > $TMPDIR/gmeta.txt && cat $TMPDIR/gmeta.txt'
alias gi='g rev-list --left-right --count master...iOS-Tester'
alias gpod='git push origin --delete'
alias hpr='hub pull-request -m'
alias hc='hub compare'
alias hb='hub browse'
alias gmm='git merge master'
alias mru='mr update'
#Generic
alias v='mvim'
alias e='/Applications/Emacs.app/Contents/MacOS/bin-x86_64-10_9/emacsclient -n'
alias vi='/Applications/MacVim.app/Contents/bin/vim'
alias h='history'
alias l='ls -lth'
alias pc='pwd | pbcopy'
alias r='tmux rename-window'
alias o='open'
alias mvim='open -a MacVim'
#Go
alias gob='go build'
alias gobt='go build && go test'
alias got='go test'
#Maven
alias mvnie='mvn install eclipse:eclipse'
alias mvni='mvn install'
alias mvnist='mvn install -DskipTests -Denforcer.skip=true -Dcheckstyle.skip=true'
alias mvnisto='mvn install -DskipTests --offline'
#Task
alias to=taskopen
alias ta=task add


#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/Users/bchandrasekaran/.sdkman"
[[ -s "/Users/bchandrasekaran/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/bchandrasekaran/.sdkman/bin/sdkman-init.sh"
