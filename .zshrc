
# Path to your oh-my-zsh installation.
export ZSH=/Users/paulwochnowski/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="af-magic"

##############################################################################
## History Configuration
###############################################################################
#HISTSIZE=5000               #How many lines of history to keep in memory
#HISTFILE=~/.zsh_history     #Where to save history to disk
#SAVEHIST=5000               #Number of history entries to save to disk
##HISTDUP=erase               #Erase duplicates in the history file
#setopt    appendhistory     #Append history to the history file (no overwriting)
#setopt    sharehistory      #Share history across terminals
#setopt    incappendhistory  #Immediately append to the history file, not just when a term is killed

# Enable command auto-correction.
# ENABLE_CORRECTION="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.


source ~/antigen.zsh

#Load the oh-my-zsh's library.
antigen use oh-my-zsh

# # Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundle web-search
antigen bundle perl
antigen bundle last-working-dir
antigen bundle git
antigen bundle common-aliases
antigen bundle heroku
antigen bundle pip
antigen bundle lein
antigen bundle command-not-found
antigen bundle hacker-quotes

antigen bundle unixorn/tumult.plugin.zsh 
antigen bundle MichaelAquilina/zsh-you-should-use

#Syntax highlighting bundle.
#antigen bundle zsh-users/zsh-syntax-highlighting

# Tell Antigen that you're done.
antigen apply

source $ZSH/oh-my-zsh.sh

# User configuration
export EDITOR='vim'

# Compilation flags
export ARCHFLAGS="-arch x86_64"

# ssh
export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
alias python=python3
alias pip=pip3
alias cse="ssh -x -Y z5079392@cse.unsw.edu.au"
#alias password=diceware-password
source /Users/paulwochnowski/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
