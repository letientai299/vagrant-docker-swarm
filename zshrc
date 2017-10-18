# Install if not installed
if [ ! -f ~/.zplug/zplug ]; then
  echo "Zplug not found, installing to home..."
  git clone https://github.com/b4b4r07/zplug ~/.zplug
  # There's a problem with v2 that make theme not load correctly
  cd ~/.zplug/
  git checkout v1
  cd ~
  echo "Done."
fi

source ~/.zplug/zplug

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

# Then, source plugins and add commands to $PATH
zplug load

export ZSH_THEME="avit"
export PATH="$PATH:$HOME/.local/bin"
alias d="docker"
alias h="http"

