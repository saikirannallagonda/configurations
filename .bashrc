#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return


# -------------------------
# Prompt matching desert colorscheme with colored square brackets:
PS1='\[\e[1;33m\][\[\e[1;36m\]\u@\h \[\e[1;37m\]\w\[\e[1;33m\]]\[\e[0m\] \$ '

# Truncate the directory path in \w to show only last directory
PROMPT_DIRTRIM=1

# Aliases for convenience and color support
alias ls='ls --color=auto'
alias ll='ls -lha --color=auto'
alias la='ls -A --color=auto'
alias l='ls -CF --color=auto'
alias grep='grep --color=auto'

# Enable bash completion if available
if [ -f /etc/bash_completion ]; then
  . /etc/bash_completion
fi

# History settings for better usability
HISTCONTROL=ignoredups:erasedups  # Avoid duplicate entries
HISTSIZE=10000
HISTFILESIZE=20000
shopt -s histappend               # Append to history, don't overwrite

# Bash options for better experience
shopt -s checkwinsize  # Update terminal size after resizing
shopt -s autocd        # Change directory without typing cd
shopt -s cdspell       # Correct minor typos in cd

# Enable color support for 'ls' command
if command -v dircolors >/dev/null 2>&1; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi

# Set LESS to show raw control characters for colors
export LESS='-R'

# Enable color output for common commands
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

# Default editor and visual
export EDITOR=nvim
export VISUAL=nvim

# Enable mouse support in terminal if desired (uncomment below)
# set -o mouse

# End of .bashrc
