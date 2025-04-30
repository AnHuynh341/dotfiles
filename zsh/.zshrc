# User specific environment
case ":$PATH:" in
  *":$HOME/.local/bin:"*) ;;
  *) PATH="$HOME/.local/bin:$HOME/bin:$PATH" ;;
esac

export PATH

#zsh autosuggest setup
export MY_ZSH_PLUGINS=~/dotfiles/zsh/plugins 
source $MY_ZSH_PLUGINS/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_STRATEGY=(history completion)



# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
# Run scripts in ~/.bashrc.d (if any)
if [ -d ~/.bashrc.d ]; then
    for rc in ~/.bashrc.d/*; do
        if [ -f "$rc" ]; then
            . "$rc"
        fi
    done
fi
unset rc

# Aliases (Zsh-specific formatting)
#alias ls='eza -lah --icons --group-directories-first --no-user --no-permissions --header  --color=always '
# alias btop='kitty -e btop &'
alias ls=" eza -a --icons --group-directories-first --grid --color=always"
alias chrome='google-chrome-stable --enable-wayland-ime > /dev/null 2>&1 & disown'
alias cleanup='sudo dnf autoremove && sudo dnf clean all && sudo journalctl --vacuum-time=7d'
alias stress-test='stress-ng --cpu 0 --cpu-method all --verify --timeout 30s'
alias mhz='watch -n 1 "cat /proc/cpuinfo | grep 'MHz'"'
#alias fzb='fzf --preview "bat --style=numbers --color=always --line-range :500 {}"'
alias fzb='find ~ \( -path ~/.android -o -path ~/development -o -path ~/.cache -o -path ~/.dartServer -o -path ~/.gradle \) -prune -o -type f -print | fzf --preview "bat --style=numbers --color=always --line-range :500 {}"'


alias prand="~/push_random.sh"

# Set up fzf key bindings and fuzzy completion
[[ -f ~/.fzf.zsh ]] && source ~/.fzf.zsh

#alias ncm='kitty --class=ncmpcpp -e ncmpcpp &'




nvimdoc() {
  local dir
  dir=$( find /mnt/localdisk/Document -mindepth 1 -maxdepth 2 -type d -not -path "/mnt/localdisk/Document/offload_fromlinux*" | fzf --prompt="Choose folder: " ) || return
  cd "$dir" && nvim .
}


ncmp() {
  {
    local music_dir="/mnt/localdisk/Audio"
    local file rel_path

    if [ -n "$1" ]; then
      rel_path="$1"
    else
      file=$(find "$music_dir" \( -iname "*.mp3" -o -iname "*.flac" -o -iname "*.wav" -o -iname "*.dsf" -o -iname "*.mka" \) -type f 2>/dev/null | fzf)

      [ -z "$file" ] && return
      rel_path="${file#"$music_dir/"}"
    fi

   	# mpc add "$rel_path" && mpc play
	# Add to the queue and fetch its position
	mpc add "$rel_path"
	song_pos=$(mpc playlist | wc -l)
	mpc play "$song_pos"


    if [ -n "$TMUX" ]; then
      # Count the number of panes
      local num_panes
      num_panes=$(tmux list-panes | wc -l)

      # Launch ncmpcpp if not already running
      if ! tmux list-panes -a -F '#{pane_current_command}' | grep -q "^ncmpcpp$"; then
        if [ "$num_panes" -eq 1 ]; then
          tmux split-window -h -d "ncmpcpp"
        else
          local right_pane
          right_pane=$(tmux list-panes -F '#{pane_id} #{pane_left}' | sort -k2 -n | tail -n1 | cut -d' ' -f1)
          tmux split-window -v -d -t "$right_pane" "ncmpcpp"
        fi
      else
        echo "ncmpcpp is already running in tmux"
      fi

      # Now check and launch cava if not running

         if ! tmux list-panes -a -F '#{pane_current_command}' | grep -q "^cava$"; then
        local bottom_pane
        bottom_pane=$(tmux list-panes -F '#{pane_id} #{pane_top}' | sort -k2 -nr | head -n1 | cut -d' ' -f1)
        tmux split-window -v -d -t "$bottom_pane" "cava"
      else
        echo "cava is already running in tmux"
      fi

    else
      # Outside tmux fallback
      if ! pgrep -x "ncmpcpp" > /dev/null; then
       # kitty --class=ncmpcpp -e ncmpcpp &
	wezterm start --class ncmpcpp -- ncmpcpp &
      fi
      if ! pgrep -x "cava" > /dev/null; then
       # kitty --class=cava -e cava &
        wezterm start --class cava -- cava &
      fi
    fi
  } &>/dev/null
}





mpv() {
  if [ "$#" -eq 0 ]; then
    local file
    file=$(find /mnt/localdisk/Video/ -type f \( -iname '*.mp4' -o -iname '*.mkv' -o -iname '*.avi' \) | fzf --height=40% --layout=reverse --prompt="🎬 Pick a video: ")
    if [ -n "$file" ]; then
      echo " 🎞️ Now playing: $file"
      # Print stream info
      mpv --vo=null --ao=null --frames=0 "$file" 2>&1 | grep -E '^● (Video|Audio|Subs)' || echo "ℹ️ No stream info found."

      # Detach and play
      nohup mpv --no-terminal "$file" > /dev/null 2>&1 &
      disown
      #echo "Detached from terminal"
    fi
  else
    command mpv "$@"
  fi
}



btop() {
  if [ -n "$TMUX" ]; then
    # Count the number of panes in the current window
    local num_panes
    num_panes=$(tmux list-panes | wc -l)

    # Check if btop is already running in any pane
    if ! tmux list-panes -a -F '#{pane_current_command}' | grep -q "^btop$"; then
      if [ "$num_panes" -eq 1 ]; then
        # Only one pane: split horizontally
        tmux split-window -h -d "btop"
      else
        # More than one pane: find the rightmost pane and split vertically from there
        local right_pane
        right_pane=$(tmux list-panes -F '#{pane_id} #{pane_left}' | sort -k2 -n | tail -n1 | cut -d' ' -f1)

        # Now split vertically from that rightmost pane
        tmux split-window -v -d -t "$right_pane" "btop"
      fi
    else
      echo "btop is already running in tmux"
    fi
  else
    # Outside tmux: check if kitty has a visible btop process
    if ! pgrep -x "kitty" -a | grep -q "btop"; then
      kitty --class=btop -e btop &
    else
      echo "btop is already running in kitty"
    fi
  fi
}





ncm() {
  {
 
	  mpc play

    if [ -n "$TMUX" ]; then
      # Count the number of panes
      local num_panes
      num_panes=$(tmux list-panes | wc -l)

      # Launch ncmpcpp if not already running
      if ! tmux list-panes -a -F '#{pane_current_command}' | grep -q "^ncmpcpp$"; then
        if [ "$num_panes" -eq 1 ]; then
          tmux split-window -h -d "ncmpcpp"
        else
          local right_pane
          right_pane=$(tmux list-panes -F '#{pane_id} #{pane_left}' | sort -k2 -n | tail -n1 | cut -d' ' -f1)
          tmux split-window -v -d -t "$right_pane" "ncmpcpp"
        fi
      else
        echo "ncmpcpp is already running in tmux"
      fi

      # Now check and launch cava if not running

         if ! tmux list-panes -a -F '#{pane_current_command}' | grep -q "^cava$"; then
        local bottom_pane
        bottom_pane=$(tmux list-panes -F '#{pane_id} #{pane_top}' | sort -k2 -nr | head -n1 | cut -d' ' -f1)
        tmux split-window -v -d -t "$bottom_pane" "cava"
      else
        echo "cava is already running in tmux"
      fi

    else
      # Outside tmux fallback
      if ! pgrep -x "ncmpcpp" > /dev/null; then
       # kitty --class=ncmpcpp -e ncmpcpp &
	wezterm start --class ncmpcpp -- ncmpcpp &
      fi
      if ! pgrep -x "cava" > /dev/null; then
       # kitty --class=cava -e cava &
        wezterm start --class cava -- cava &
      fi
    fi
  } &>/dev/null
}




ncmo() {
	     # Outside tmux fallback
      if ! pgrep -x "ncmpcpp" > /dev/null; then
       # kitty --class=ncmpcpp -e ncmpcpp &
	wezterm start --class ncmpcpp -- ncmpcpp &
      fi
      if ! pgrep -x "cava" > /dev/null; then
       # kitty --class=cava -e cava &
       sleep 0.75
        wezterm start --class cava -- cava &
      fi

}





# Set up environment variables for development tools
export PATH="$HOME/development/flutter/bin:$PATH"
export ANDROID_SDK_ROOT=$HOME/development/android-sdk
export ANDROID_HOME=$ANDROID_SDK_ROOT
export PATH=$ANDROID_SDK_ROOT/cmdline-tools/latest/bin:$PATH
export PATH=$ANDROID_SDK_ROOT/platform-tools:$PATH
export PATH=$ANDROID_SDK_ROOT/emulator:$PATH
export PATH=$ANDROID_SDK_ROOT/build-tools/34.0.0:$PATH
#export JAVA_HOME=/usr/lib/jvm/java-21-openjdk
export JAVA_HOME=/usr/lib/jvm/temurin-17-jdk


# Input method configurations for fcitx
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
export SDL_IM_MODULE=fcitx
export GLFW_IM_MODULE=ibus



# Set LS_COLORS for custom file highlighting
export LS_COLORS="${LS_COLORS}ow=1;33:"


# Initialize Starship prompt
eval "$(starship init zsh)"


# Optional: Run neofetch (if desired) – remove if you want to avoid it on startup
 fastfetch



# Start tmux automatically if not already in a tmux session
if [[ -z $TMUX ]]; then
  tmux attach-session -t main || tmux new-session -s main
fi


