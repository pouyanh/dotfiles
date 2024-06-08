prehook() {
  plugins+=(tmux)

  ZSH_TMUX_AUTOSTART=true
  ZSH_TMUX_CONFIG="$HOME/.config/tmux/tmux.conf"
}
