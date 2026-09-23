1. Create a symlink to the tmux config file

```bash
mkdir -p ~/.config/tmux
ln -s ~/go/src/github.com/pouyanh/dotfiles/tmux/tmux.conf ~/.config/tmux/tmux.conf
```

2. Renew the tmux session: `tmux kill-server` and re-run tmux
3. Execute Prefix+I in tmux to reload the environment. Prefix is C-b by default and I must be capital (Shift+i)
