export PATH="/usr/local/sbin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

export JAVA_HOME="$(/usr/libexec/java_home)"

export ANDROID_HOME="$HOME/Library/Android/sdk"
export ANDROID_SDK_ROOT="$ANDROID_HOME"

if type "anyenv" > /dev/null 2>&1; then
  eval "$(anyenv init -)"
fi

if type "nodenv" > /dev/null 2>&1; then
  export NODENV_ROOT="$HOME/.nodenv"
  export PATH="$NODENV/bin:$PATH"
  eval "$(nodenv init -)"
fi

if type "pyenv" > /dev/null 2>&1; then
  export PYENV_ROOT="$HOME/.pyenv"
  export PATH="$PYENV/bin:$PATH"
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
fi

if type "rbenv" > /dev/null 2>&1; then
  export RBENV_ROOT="$HOME/.rbenv"
  export PATH="$RBENV/bin:$PATH"
  eval "$(rbenv init -)"
fi

if type "goenv" > /dev/null 2>&1; then
  export GOENV_ROOT="$HOME/.goenv"
  export PATH="$GOENV_ROOT/bin:$PATH"
  eval "$(goenv init -)"
  export PATH="$GOROOT/bin:$PATH"
  export PATH="$PATH:$GOPATH/bin"
fi

# The next line updates PATH for the Google Cloud SDK.
if [ -f "~/google-cloud-sdk/path.zsh.inc" ]; then
  . "~/google-cloud-sdk/path.zsh.inc"
fi

# The next line enables shell command completion for gcloud.
if [ -f "~/google-cloud-sdk/completion.zsh.inc" ]; then
  . "~/google-cloud-sdk/completion.zsh.inc"
fi

if [ -f "~/.zshrc" ]; then
  . "~/.zshrc"
fi

if type "fish" > /dev/null 2>&1; then
  export TO_FISH_PATH="$PATH"
  exec "fish"
fi
