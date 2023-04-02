# 0kate's dotfiles

## Installation
```
git clone https://github.com/0kate/dotfiles.git
cd dotfiles
./install.sh
```

## Philosophy
The directory structure follows a home directory structure.  
For example, a file placed to `path/to/dotfiles/.config/emacs/init.el` will be linked to `path/to/home/.config/emacs/init.el`.

## Special files
This dotfiles repository provides some special files to customize installation process.

### .dotfilesignore
You can specify additional paths into this file for ignoring from linking targets. (like .gitignore)  
Files specified into `.dotfilesignore` doesn't link to your home directory.  
Default ignores are `.git/`, `.dotfilesignore`, `hooks/` and `install.sh` are defined in the `install.sh`.

**Example**
`.dotfilesignore`
```
a.txt
hoge
```

Files to be ignored are below.
```
.git/
.dotfilesignore
hooks/
install.sh
a.txt
hoge/
```

### hooks/{before,after}_link.sh
You can define scripts to be hooked before and after linking process.  
These hooks scripts must be placed to under the `hooks/` directory.  
For example, you can use this mechanism to enable systemd unit after placed unit files with linking process.

**Example**
hooks/before_link.sh
```
#!/usr/bin/env bash

set -eu

This is a script hooked before linking.
```

hooks/after_link.sh
```
#!/usr/bin/env bash

set -eu

This is a script hooked after linking.
systemctl enable --user emacs.service
```

Output on installation
```
This is a script hooked before linking.
This is a script hooked after linking.
```
