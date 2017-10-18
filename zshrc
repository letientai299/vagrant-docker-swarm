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
zplug "zsh-users/zsh-syntax-highlighting", nice:10
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-completions"
zplug "supercrabtree/k" # directory listing with git supported
zplug "Tarrasch/zsh-bd" # back-cd

# auto close the matching pair, must be load after compinit, hence nice:10.
zplug "hlissner/zsh-autopair", nice:10

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
  printf "Install? [y/N]: "
  if read -q; then
    zplug install
  fi
fi

export ZSH_THEME="avit"

zplug load

alias d="docker"
alias h="http"
export PATH="$PATH:$HOME/.local/bin"
