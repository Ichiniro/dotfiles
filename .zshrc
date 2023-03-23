# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/dekaichi/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="kardan" # set by `omz`
# Temas utiles
# takashiyoshida
# avit
# evan
# kolo
# amuse
# arrow
# edvardm
# emotty
# fwalch
# imajes
# jnrowe
# kiwi
# smt
# sporty_256
# wezm+
# dstufft
# terminalparty

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

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
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    git
    history-substring-search
    colored-man-pages
    zsh-autosuggestions
    zsh-syntax-highlighting
    zsh-z
    emotty
    emoji
    zsh-256color
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
   export EDITOR='vim'
else
   export EDITOR='vim'
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias fet="sh ~/.toys/fet.sh"
alias :q="exit"
alias lh='lsd -lh'
alias ls='lsd'
alias rice="sh $HOME/.config/polybar/scripts/rice.sh"
alias sc="sh $HOME/.config/polybar/scripts/scheme.sh"
alias endksession="qdbus org.kde.kmserver /KSMServer logout 1 3 3"
alias colorpanes="sh $HOME/.toys/colorpanes"
alias colorline="sh $HOME/.toys/colorline"
alias kdecs='./.config/autostart/kdecs'
alias colorz='colorz --no-preview -n 6'

# Command to create a folder and cd'd into the folder
mkcd () {
    mkdir "$1"
    cd "$1"
}

unsetopt prompt_cr prompt_sp

setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_ALL_DUPS

# Add pip3 to PATH
# export PATH="${PATH}:${HOME}/.local/bin/"

#sh ~/.toys/maki.sh
#figlet "Nanisore? Imi wakannai" -c -k -t

# Ignore some commands from history
HISTORY_IGNORE='(fet *|colorpanes *|colorline *|cpumode *|cpuperformance *|cpupowersave *|ls *|rice *|sc *|:q *|colorz *)'

# Custom highlight
typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[alias]='fg=#6B90AD'
ZSH_HIGHLIGHT_STYLES[command]='fg=#6B90AD'
ZSH_HIGHLIGHT_STYLES[builtin]='fg=#6B90AD'
ZSH_HIGHLIGHT_STYLES[precommand]='fg=#6B90AD'
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=#505053'

# Change color of autosuggestions
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=8"
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
ZSH_AUTOSUGGEST_HISTORY_IGNORE="sc *|"

# Add game scripts folder to path
export PATH="${PATH}:${HOME}/.local/bin/"

# Fix for video playback in Firefox 98
# export MOZ_DISABLE_RDD_SANDBOX=1

SESSSION=$(loginctl show-session $(awk '/tty/ {print $1}' <(loginctl)) -p Type | awk -F= '{print $2}')
if [[ $SESSSION -eq "wayland" ]]; then
    MOZ_ENABLE_WAYLAND=1
fi
export GPG_TTY=$(tty)
