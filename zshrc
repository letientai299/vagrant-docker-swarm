export LANGUAGE=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Install if not installed
if [ ! -f ~/.zplug/init.zsh ]; then
  curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh| zsh
fi

source ~/.zplug/init.zsh

zplug 'robbyrussell/oh-my-zsh', use:oh-my-zsh.sh

# Plugins from oh-my-zsh
for p in {git,colored-man-pages,z,gradle};
do
  zplug "plugins/$p", from:oh-my-zsh
done

# Other plugins
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-completions"
zplug "supercrabtree/k" # directory listing with git supported
zplug "Tarrasch/zsh-bd" # back-cd

zplug "hlissner/zsh-autopair", defer:2

# Theme
zplug "xfanwu/oh-my-zsh-custom-xxf", use:"themes/*.zsh-theme", defer:2


# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
  printf "Install? [y/N]: "
  if read -q; then
    zplug install
  fi
fi

zplug load

alias d="docker"
alias h="http"
export PATH="$PATH:$HOME/.local/bin"
alias tmux="TERM=xterm-256color tmux"
