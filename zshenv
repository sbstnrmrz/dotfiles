alias vim=nvim
alias ls='ls -lah'
HOMEBREW_NO_AUTO_UPDATE=1

# original prompt %n@%m %1~ %#

#export PS1="[%n@%m %1~] %#"

ALACRITTY="/Applications/Alacritty.app/Contents/MacOS/alacritty"
SCILAB="/Applications/scilab-2025.0.0.app/Contents/bin/"
RUBY="~/.rbenv/versions/3.3.6/bin/"
PYTHON="/usr/bin/python"
ZIG="/usr/local/zig/"
EMSDK1="~/.local/src/emsdk/"
EMSDK2="~/.local/src/emsdk/upstream/emscripten/"
ASEPRITE="/Users/sebass/.local/src/Aseprite-v1.3.14-beta1-Source/build/bin"

EMSDK="/Users/sebass/.local/src/emsdk"
EMSDK_NODE="/Users/sebass/.local/src/emsdk/node/20.18.0_64bit/bin/node"
EMSDK_PYTHON="/Users/sebass/.local/src/emsdk/python/3.9.2_64bit/bin/python3"

export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools
ADB='/Users/sebass/Library/Android/sdk/platform-tools'

export PATH="$PATH:$EMSDK:$EMSDK1:$EMSDK2:$ALACRITTY:$ZIG:$RUBY:$SCILAB:$ASEPRITE:$ADB"
. "$HOME/.cargo/env"
