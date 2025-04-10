# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
    for rc in ~/.bashrc.d/*; do
        if [ -f "$rc" ]; then
            . "$rc"
        fi
    done
fi
unset rc
neofetch

alias gpt='chrome https://chat.openai.com'
export PATH="$HOME/development/flutter/bin:$PATH"

export ANDROID_SDK_ROOT=$HOME/development/android-sdk
export ANDROID_HOME=$ANDROID_SDK_ROOT
export PATH=$ANDROID_SDK_ROOT/cmdline-tools/latest/bin:$PATH
export PATH=$ANDROID_SDK_ROOT/platform-tools:$PATH
export PATH=$ANDROID_SDK_ROOT/emulator:$PATH
export PATH=$ANDROID_SDK_ROOT/build-tools/34.0.0:$PATH
export JAVA_HOME=/usr/lib/jvm/java-17-openjdk
export JAVA_HOME=/usr/lib/jvm/java-17-openjdk


# export GTK_IM_MODULE=ibus
# export QT_IM_MODULE=ibus
# export XMODIFIERS=@im=ibus


# alias audio="nohup strawberry  >/dev/null 2>&1 &"

alias files="nohup dolphin >/dev/null 2>&1 &"
 # alias movie='cd '\''/run/media/AnHuynh/Local Disk/Video'\'''
alias movie='cd "/mnt/localdisk/Video"'

#alias ncm='kitty --class=ncmpcpp -e ncmpcpp &'


mpv() {
    command mpv "$@" &>/dev/null &
}


export LS_COLORS="${LS_COLORS}ow=1;33:"


alias ls='eza -l --icons --group-directories-first --no-user --no-permissions --header --grid --color=always '

alias bpytop='alacritty -e bpytop &'

# alias chrome='google-chrome-stable --enable-wayland-ime'
 
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
export SDL_IM_MODULE=fcitx
export GLFW_IM_MODULE=ibus

alias chrome='google-chrome-stable --enable-wayland-ime > /dev/null 2>&1 & disown'



eval "$(oh-my-posh init bash --config ~/.poshthemes/night-owl.omp.json)"


