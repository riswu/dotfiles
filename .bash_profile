export PATH=/usr/local/sbin:$PATH
export PATH=$HOME/.local/bin:$PATH
export PATH=$HOME/.nodebrew/current/bin:$PATH

export JAVA_HOME=$(/usr/libexec/java_home)

export ANDROID_HOME=$HOME/Library/Android/sdk
export ANDROID_SDK_ROOT=$ANDROID_HOME

eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

export PATH=$HOME/.rbenv/bin:$PATH
eval "$(rbenv init -)"

export GOENV_ROOT=$HOME/.goenv
export PATH=$GOENV_ROOT/bin:$PATH
eval "$(goenv init -)"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/keitasugiyama/google-cloud-sdk/path.bash.inc' ]; then
  . '/Users/keitasugiyama/google-cloud-sdk/path.bash.inc';
fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/keitasugiyama/google-cloud-sdk/completion.bash.inc' ]; then
  . '/Users/keitasugiyama/google-cloud-sdk/completion.bash.inc';
fi

if [ -f ~/.bashrc ]; then
  . ~/.bashrc
fi

export TO_FISH_PATH=$PATH
exec fish
