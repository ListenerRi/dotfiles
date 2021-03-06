# If you come from bash you might have to change your $PATH.
#export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=/home/ri/bin:/home/ri/.local/bin:/home/ri/go/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=/home/ri/.oh-my-zsh

# to avoid warnning when other user use zsh
ZSH_DISABLE_COMPFIX="true"

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to load
# Setting this variable when ZSH_THEME=random
# cause zsh load theme from this variable instead of
# looking in ~/.oh-my-zsh/themes/
# An empty array have no effect
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

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
#DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

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
plugins=(
    autojump
    zsh-autosuggestions
    tmux
    zsh-completions
)

# for plugin zsh-autosuggestions
bindkey '^ ' autosuggest-accept

bindkey \^U backward-kill-line

# for plugin tmux
export ZSH_TMUX_AUTOSTART=true
export ZSH_TMUX_AUTOSTART_ONCE=false
export ZSH_TMUX_AUTOCONNECT=false

# for plugin zsh-completions
fpath=($ZSH/custom/plugins/zsh-completions/src $fpath)

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
alias ll='ls -alF --color=auto'
alias la='ls -AF --color=auto'
alias ls='ls -F --color=auto'
alias info='info --vi-keys'
alias en='export LANG=en_US.UTF-8 && export LANGUAGE=en_US'
alias zh='export LANG=zh_CN.UTF-8 && export LANGUAGE=zh_CN'

alias au='sudo apt update'
alias al='apt list'
alias as='apt show'
alias ap='apt policy'
alias alu='sudo apt list --upgradable'
alias af='sudo apt full-upgrade'
alias ai='sudo apt install'
alias ar='sudo apt remove --purge'
alias aar='sudo apt autoremove --purge'
alias aac='sudo apt autoclean'

alias gl='git log'
alias glr='git log --graph'
alias gs='git status'
alias gd='git diff'
alias ga='git add .'
alias gc='git commit'
alias gca='git commit --amend'
alias gpl='git pull'
alias gps='git push'
alias gb='git branch'
alias gbd='git branch -d'
alias gbD='git branch -D'
alias gch='git checkout'
alias gcm='git checkout master'
alias gdm='git diff master'
alias gsl='git stash list'
alias gsi='git stash push'
alias gso='git stash pop'
alias gsd='git stash drop'
alias gss='git stash show -p'

#alias gr='git review -r origin'
gr() {
    branch_array=($(git branch | cut -b 3-))

    index=1
    for branch in "${branch_array[@]}"; do
        if [[ $branch == master ]]; then
            echo "[$index] $branch"
        else
            echo " $index  $branch"
        fi
        index=$(expr $index + 1)
    done

    echo -n "specify a branch to review: "
    read selected_index

    # default branch is master
    if [[ -z $selected_index ]]; then
        echo "review to branch master:"
        git review -r origin master
        return $?
    fi

    selected_branch=${branch_array[$selected_index]}
    if [[ -n $selected_branch ]]; then
        echo "review to branch $selected_branch: "
        git review -r origin $selected_branch
        return $?
    else
        echo "Error: specified branch can not find!";
    fi
}

#alias grm='git rebase master'
grm() {
    flag=$(git branch | grep "\\* dev/")
    if [[ -n $flag ]]; then
        echo "Warning: rebase master in dev branch!"
        echo "use complete command 'git rebase master' if you really want to do this!"
    else
        git rebase master
    fi
}

alias m='make -j4'
alias mk='make'

alias dd='dd status=progress'

# Set colors for man pages
man() {
  env \
  LESS_TERMCAP_mb=$(printf "\e[1;31m") \
  LESS_TERMCAP_md=$(printf "\e[1;31m") \
  LESS_TERMCAP_me=$(printf "\e[0m") \
  LESS_TERMCAP_se=$(printf "\e[0m") \
  LESS_TERMCAP_so=$(printf "\e[1;41;33m") \
  LESS_TERMCAP_ue=$(printf "\e[0m") \
  LESS_TERMCAP_us=$(printf "\e[1;32m") \
  man "$@"
}

export EDITOR=vim
export PROMPT='${ret_status} %{$fg[cyan]%}%n@%m %{$fg[green]%}%~%{$reset_color%} $(git_prompt_info)'

# Add environment variable COCOS_CONSOLE_ROOT for cocos2d-x
export COCOS_CONSOLE_ROOT="/home/ri/coding/cocos2d-x-3.17/tools/cocos2d-console/bin"
export PATH=$COCOS_CONSOLE_ROOT:$PATH

# Add environment variable COCOS_X_ROOT for cocos2d-x
export COCOS_X_ROOT="/home/ri/coding"
export PATH=$COCOS_X_ROOT:$PATH

# Add environment variable COCOS_TEMPLATES_ROOT for cocos2d-x
export COCOS_TEMPLATES_ROOT="/home/ri/coding/cocos2d-x-3.17/templates"
export PATH=$COCOS_TEMPLATES_ROOT:$PATH

# Add environment variable COCOS_CONSOLE_ROOT for cocos2d-x
export COCOS_CONSOLE_ROOT="/home/ri/coding/cocos2d-x-3.17/tools/cocos2d-console/bin"
export PATH=$COCOS_CONSOLE_ROOT:$PATH

# Add environment variable COCOS_X_ROOT for cocos2d-x
export COCOS_X_ROOT="/home/ri/coding"
export PATH=$COCOS_X_ROOT:$PATH

# Add environment variable COCOS_TEMPLATES_ROOT for cocos2d-x
export COCOS_TEMPLATES_ROOT="/home/ri/coding/cocos2d-x-3.17/templates"
export PATH=$COCOS_TEMPLATES_ROOT:$PATH

# Add environment variable NDK_ROOT for cocos2d-x
export NDK_ROOT="/home/ri/android-sdk-linux/ndk-bundle"
export PATH=$NDK_ROOT:$PATH

# Add environment variable ANDROID_SDK_ROOT for cocos2d-x
export ANDROID_SDK_ROOT="/home/ri/android-sdk-linux"
export PATH=$ANDROID_SDK_ROOT:$PATH
export PATH=$ANDROID_SDK_ROOT/tools:$ANDROID_SDK_ROOT/platform-tools:$PATH

export GOROOT=/usr/lib/go
export GOPATH=/home/ri/go
