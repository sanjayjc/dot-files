test -z "$PROFILEREAD" && . /etc/profile

# Width-limited prompt
PROMPT_COMMAND="dir=\${PWD/\$HOME/~}; limit=25; test \${#dir} -gt \$limit && dir=...\${dir:\$[\${#dir}-\$[\$limit - 4]]}; PS1=\"[\h:\$dir]$ \""
export PROMPT_COMMAND

EDITOR=emacsclient
export EDITOR

PATH=$HOME/pubsoft/Linux/bin:$HOME/pubsoft/bin:$HOME/scripts:$PATH
export PATH

JAVA_HOME=/usr/local/woodstock/JDK/jdk1.6.0_16-chicago
PATH=$JAVA_HOME/bin:$PATH
export JAVA_HOME

PAGER=""
export PAGER