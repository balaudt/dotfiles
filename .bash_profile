export PATH=$PATH:/Users/balamurugan/apps/apache-maven-3.3.9/bin/:/Users/balamurugan/apps/scala-2.12.0/bin:/Users/balamurugan/apps:/Users/balamurugan/source/hub/bin:/Users/balamurugan/apps/spark-2.1.0-bin-hadoop2.7/bin
#Plugins PATH extension
export PATH=$PATH:/usr/local/opt/llvm/bin/:/usr/local/Cellar/cmake/3.7.1/bin/
export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_112.jdk/Contents/Home
export OS_AUTH_URL=http://keystoneservice.ostk.dv1.vip.corp.gq1.yahoo.com:5000/v2.0
export OS_USERNAME=balamurugan
export EDITOR=mvim
export OS_TENANT_NAME=balamurugan
export SPARK_CONF_DIR=/Users/balamurugan/apps/spark-2.1.0-bin-hadoop2.7/conf
export SPARK_CONF_HOME=/Users/balamurugan/apps/spark-2.1.0-bin-hadoop2.7/

#test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

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
#Maven
alias mvnie='mvn install eclipse:eclipse'
alias mvni='mvn install'
alias mvnist='mvn install -DskipTests -Denforcer.skip=true -Dcheckstyle.skip=true'
alias mvnisto='mvn install -DskipTests --offline'
#Task
alias to=taskopen
alias ta=task add

# added by Anaconda3 4.2.0 installer
export PATH=$PATH:/Users/balamurugan/anaconda/bin

#Hadoop manual install
export PATH=$PATH:/Users/balamurugan/apps/hadoop-2.8.0/bin
export HADOOP_HOME=/Users/balamurugan/apps/hadoop-2.8.0
export HADOOP_CONF=/Users/balamurugan/dev/common/conf/axonite




export PATH="$HOME/.cargo/bin:$PATH"
