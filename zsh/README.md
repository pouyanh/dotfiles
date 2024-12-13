# ZSH
The [Z shell][zsh] is a Unix shell that can be used as an interactive login shell and as a command interpreter for shell scripting

# Using this file

## Requirements
I've installed [Oh my zsh][ohmyzsh] in `/usr/share/oh-my-zsh` to feel better

## Put the configuration file
You can link your zsh config file by making a symbolic link to current file

```sh
ln -s ~/path/to/repo/dotfiles/zsh/zshrc ~/.zshrc
```

## Use extensions
Link or copy your desired extensions from ext directory:

```sh
copy ~/path/to/repo/dotfiles/zsh/ext/00-no-autoupdate.zsh ~/.config/zsh/
copy ~/path/to/repo/dotfiles/zsh/ext/10-plugin-docker.zsh ~/.config/zsh/
copy ~/path/to/repo/dotfiles/zsh/ext/10-plugin-git.zsh ~/.config/zsh/
```

[zsh]: https://www.zsh.org/
[ohmyzsh]: https://ohmyz.sh/
