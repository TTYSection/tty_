#!/usr/bin/env zsh
#   _________  _   _ ____   ____ 
#  |__  / ___|| | | |  _ \ / ___|
#    / /\___ \| |_| | |_) | |    
# _ / /_ ___) |  _  |  _ <| |___ 
#(_)____|____/|_| |_|_| \_\\____|
#
#   
######################################
######################################
################ EXEC ################
archey3								 #
#echo "▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓";#
#echo "";							 #
######################################
######################################
# Path to your oh-my-zsh installation.
export ZSH=/home/aaf/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="af-magic"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

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
plugins=(git)

autoload -U promptinit
promptinit

# Completion
autoload -U bashcompinit
autoload -U incremental-complete-word
autoload -U compinit
bashcompinit
compinit -C
zmodload zsh/complist

# Language
LANG=en_US.UTF-8; export LANG
MM_CHARSET=UTF-8; export MM_CHARSET
LC_ALL=en_US.UTF-8; export LC_ALL

# Unicode
setopt printeightbit

# mv zsh
autoload zmv

# Colors
if [[ -x `which dircolors` ]]; then
    if [[ -f ~/.dir_colors ]]; then
        eval $(dircolors -b ~/.dir_colors)
    elif  [[ -f /etc/dir_colors ]]; then
        eval $(dircolors -b /etc/dir_colors)
    else
        eval $(dircolors -b)
    fi
else
    
LS_COLORS='no=00:fi=00:di=00;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:';
    export LS_COLORS
fi
export ZLS_COLORS=$LS_COLORS

# Comments
setopt  interactive_comments

# sudo completion
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin \
                           /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin /home/cocky/bin

# Completion cache
zstyle ':completion:complete:*' use-cache 1
zstyle ':completion:complete:*' cache-path ~/.zsh/cache/$HOST

# History
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

# completion colors
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# autocd...
setopt autopushd pushdminus pushdsilent pushdtohome
setopt autocd
setopt hist_ignore_all_dups

# correction
setopt correctall

# better ls ;)
function ll()
{ ls -l "$@"| egrep "^d" ; ls -lXB "$@" 2>&-| egrep -v "^d|total "; }

# cvs(1) completion
_cvs ()
{
    local cur prev
    COMPREPLY=()
    cur=${COMP_WORDS[COMP_CWORD]}
    prev=${COMP_WORDS[COMP_CWORD-1]}

    if [ $COMP_CWORD -eq 1 ] || [ "${prev:0:1}" = "-" ]; then
        COMPREPLY=( $( compgen -W 'add admin checkout commit diff \
        export history import log rdiff release remove rtag status \
        tag update' $cur ))
    else
        COMPREPLY=( $( compgen -f $cur ))
    fi
    return 0
}
complete -F _cvs cvs

# killall completion
_killall ()
{
    local cur prev
    COMPREPLY=()
    cur=${COMP_WORDS[COMP_CWORD]}

    # get a list of processes (the first sed evaluation
    # takes care of swapped out processes, the second
    # takes care of getting the basename of the process)
    COMPREPLY=( $( /bin/ps -u $USER -o comm  | \
        sed -e '1,1d' -e 's#[]\[]##g' -e 's#^.*/##'| \
        awk '{if ($0 ~ /^'$cur'/) print $0}' ))

    return 0
}
complete -F _killall killall killps

##################################################################################
# Change the window title of X terminals 
    if [[ $TERM =~ "xterm|rxvt" ]]; then
        # There are lots of other info to add. See 'prompt expansion' in
        # man zshmisc
        precmd()  { print -Pn "\e]0;%~\a"} ;
        preexec() { print -Pn "\e]0;$1\a"} ;
    fi
##################################################################################

export GREP_COLOR=31

# Alias #
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias ..='cd ..'
alias rmmod="sudo rmmod"
alias cpr="cp -R"
alias date="date +%c"

# Bash Alias #
alias e="vim"
alias es="sudo vim"
alias p="packer"
alias P="sudo pacman --color=auto"
alias y="yaourt"
alias ys="y --state"
alias news="newsbeuter"
alias C="clear"
alias Zshrc='vim /home/aaf/.zshrc'
alias Zrc='vim /home/aaf/.config/awesome/rc.lua'
alias Zrcwi='vim /home/aaf/.config/awesome/wi.lua'
alias Zrct='vim /home/aaf/.config/awesome/themes/dust/theme.lua'
alias Zarch_pwd='e /home/aaf/Documents/arch/linux/pwd'
alias du="du -sh"
alias trans="google-translate"
alias serv_pwd='cat /home/aaf/Documents/ESOTERIC/esoteric.ge/server/magic'
alias arch_com='cat /home/aaf/Documents/arch/Commands'
alias arch_pwd='cat /home/aaf/Documents/arch/linux/pwd'
alias arch_win='cd /mnt/windows/'
alias arch_music='cd /mnt/windows/Documents/Music/'
alias proc='glances'
alias trans='google-translate en ka'
alias wic="sudo wifi-menu"

# Pacman
alias pac="sudo pacman"
alias pacS="sudo pacman -S"
alias pacR="sudo pacman -R"
alias pacRs="sudo pacman -Rs"
alias pacSyu="sudo pacman -Syyu"
alias pacSs="pacman -Ss"
alias pacSg="pacman -Sg"
alias pacQs="pacman -Qs"
alias pacSi="pacman -Si"
alias pacQi="pacman -Qi"
alias pacQl="pacman -Ql"
alias pacQo="sudo pacman -Qo" 
alias pacQtd="sudo pacman -Qtd"
alias pacScc="sudo pacman -Scc" 
alias pacU="sudo pacman -U"
alias pacaurS="pacaur -S"

# The 'ls' family (this assumes you use the GNU ls)
alias la='ls -Al'               # show hidden files
alias ls='ls -hF --color'    # add colors for filetype recognition
alias lx='ls -lXB'              # sort by extension
alias lk='ls -lSr'              # sort by size
alias lc='ls -lcr'        # sort by change time  
alias lu='ls -lur'        # sort by access time   
alias lr='ls -lR'               # recursive ls
alias lt='ls -ltr'              # sort by date
alias lm='ls -al |more'         # pipe through 'more'

# User configuration
export PATH="/usr/local/sbin:/usr/local/bin:/usr/bin:/usr/lib/jvm/default/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl:/home/cocky/bin/:/sbin/:/usr/sbin/:/usr/local/bin/"
# Export MANPATH="/usr/local/man:$MANPATH"

# Export
export PAGER=/usr/bin/vimpager
export EDITOR=/usr/bin/vim
export VISUAL=/usr/bin/vim
export BROWSER=/usr/bin/chromium

# Pager
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
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
