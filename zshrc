# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="true"

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
plugins=(git)

# User configuration

export PATH=$HOME/bin:/usr/local/bin:$PATH
export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_40.jdk/Contents/Home
# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh

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
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias .ev="vim ~/.vimrc"
alias .ez="vim ~/.zshrc"
alias .es='vim ~/.oh-my-zsh/custom/shortcuts.zsh'
alias .ss='source ~/.zshrc'

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

alias aws='ssh -i ~/work/software/aws_instance.pem ec2-user@ec2-54-186-254-248.us-west-2.compute.amazonaws.com'

alias jconsole='jconsole -J-DsocksProxyHost=socks.yahoo.com -J-DsocksProxyPort=1080'
alias jeclipse='nohup /Users/allenlv/work/eclipse/eclipse -vmargs -Xms1024M -Xmx2048M -XX:+UseParallelGC -XX:PermSize=512M -XX:MaxPermSize=1024M &'
alias ll='ls -l'
alias me='mvn eclipse:eclipse'
alias moshup='mosh underquiet.peking.corp.yahoo.com -- screen'

function cs() {
	cd $1; ls;
}

function ackdelete () {
	ack -l $1 | xargs -n 1 sed -i '' -e "/$1/d"
}

function ackreplace () {
	ack -l $1 | xargs -n 1 sed -i '' -e "s/$1/$2/g"
}

function addByPattern () {
	git st -s | grep $1 | awk '{print $2}' | xargs git add
}

function check () {
	git diff --stat $1 | grep -v -E "ruleset|state|2 \+\-"
}

function checkdiff () {
	git diff --stat upstream/master | grep -v -E "ruleset|state|2 \+\-" \
    | awk '{print $1}' | grep -v 528 | xargs git diff upstream/master --
}

function current_branch () {
	ref=$(git symbolic-ref HEAD 2> /dev/null) \
    || ref=$(git rev-parse --short HEAD 2> /dev/null)  || return
	echo ${ref#refs/heads/}
}

function current_repository () {
	ref=$(git symbolic-ref HEAD 2> /dev/null)  \
    || ref=$(git rev-parse --short HEAD 2> /dev/null)  || return
	echo $(git remote -v | cut -d':' -f 2)
}

function dash () {
	~/work/software/javadocset $1 $2
}

function db() {
    git branch -D $1
    deleteRemoteBranch $1
}

function deleteRemoteBranch () {
	git branch -rd origin/$1
	git push origin :$1
}

function drop () {
	git add $1
	git reset $1
	git checkout $1
	echo done
}

function gco () {
  git checkout -- $1
}

function editAt () {
	ls -G -al | grep $1 | awk '{print $9}' | xargs -o vim
}

function edit_conflict () {
	git ls-files -u | awk '{print $4}' | sort -u | grep $1 | xargs -o vim
}

function gadd () {
	git ls-files -u | awk '{print $4}' | sort -u | grep $1 | xargs -n 1 git add
}

function gddp () {
	REV=$1
	git show -p $REV --no-prefix | patch -p0
}

function gdv () {
	git diff -w "$@" | view -
}

function lconflict () {
	git ls-files -u | awk '{print $4}' | sort -u | grep $1
}

function master_win () {
	files=$(git ls-files -u | awk '{print $4}' | sort -u | grep $1)
	while read file
	do
		echo "revert changes of $file"
		git reset -q -- $file > /dev/null && git checkout -- $file \
      && git checkout upstream/master -- $file
	done <<< "$files"
}

function merge_steps () {
	MERGE_POINT = $1
	git fetch upstream
	git checkout -B release --track upstream/release
	git merge --no-ff $MERGE_POINT
	git reset -- assembly/**/image/rule.{ruleset,state}
	git checkout -- assembly/**/image/rule.{ruleset,state}
	git status --short | grep -e "^UA" | cut -d ' ' -f 2 | xargs -n 1 git add
	git status --short | grep -e "^AU" | cut -d ' ' -f 2 | xargs -n 1 git add
	find . -type f \( -name '*yi?f' -o -name '*bim' -o -name 'Make*' \) -print0 \
    | xargs -0 -P128 grep -EH --color master
	git diff --stat $MERGE_POINT | grep -v -E "ruleset|state|2 \+\-"
	git commit
	tag_release
	tag_master
	git push upstream master-X release-Y release
}

function mkdircd () {
	mkdir -p "$@" && eval cd "\"\$$#\""
}

function mp () {
	mvn -s ~/work/shell/ymaven_settings.xml archetype:create \
    -DgroupId=$1 -DartifactId=$2
}

function msp () {
	mvn -s ~/work/shell/ymaven_settings.xml archetype:generate -DgroupId=$1 \
    -DartifactId=$2 -DremoteRepositories=http://scala-tools.org/repo-releases \
    -DarchetypeGroupId=org.scala-tools.archetypes \
    -DarchetypeArtifactId=scala-archetype-simple -Dversion=1.0-SNAPSHOT
}

function newsbt () {
	java -Xmx512M -jar /Users/lvfm/work/software/sbt-launch-0.7.7.jar "$@"
}

function re () {
	files=(./*)
	/usr/local/bin/vim "${files[RANDOM % ${#files[@]}]}"
}

function release_win () {
	files=$(git ls-files -u | awk '{print $4}' | sort -u | grep $1)
	while read file
	do
		echo "revert changes of $file"
		git reset -q -- $file > /dev/null
		git checkout -- $file
	done <<< "$files"
}

function tag_master () {
	git tag -a -m "Open new master branch $1" master-$1 upstream/master
}

function tag_release () {
	git tag -a -m "Tag for release-$1 release" release-$1 release
}

function take () {
	mkdir -p $1
	cd $1
}

function tarz () {
	tar -zcvf $1 $2
}
