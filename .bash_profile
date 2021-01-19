export PATH=/usr/local/sbin:$PATH
export PATH=$HOME/.local/bin:$PATH
export PATH=$HOME/.nodebrew/current/bin:$PATH

export JAVA_HOME=$(/usr/libexec/java_home)

export ANDROID_HOME=$HOME/Library/Android/sdk
export ANDROID_SDK_ROOT=$ANDROID_HOME

if type "pyenv" > /dev/null 2>&1; then
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
fi

if type "rbenv" > /dev/null 2>&1; then
  export PATH=$HOME/.rbenv/bin:$PATH
  eval "$(rbenv init -)"
fi

if type "goenv" > /dev/null 2>&1; then
  export GOENV_ROOT=$HOME/.goenv
  export PATH=$GOENV_ROOT/bin:$PATH
  eval "$(goenv init -)"
fi

if [ -f ~/.bashrc ]; then
  . ~/.bashrc
fi

if type "fish" > /dev/null 2>&1; then
  export TO_FISH_PATH=$PATH
  exec fish
fi
