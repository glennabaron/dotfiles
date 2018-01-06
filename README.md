# Glenna's dotfiles

**Warning:** If you want to give these dotfiles a try, you should first fork this repository, review the code, and remove things you don't want or need. Don't blindly use my settings unless you know what that entails. Use at your own risk!

### Using Git and the bootstrap script
You can clone the repository wherever you want. (I like to keep it in `~/projects/dotfiles`, with `~/dotfiles` as a symlink.) The bootstrapper script will pull in the latest version and copy the files to your home folder.

```bash
git clone https://github.com/glennabaron/dotfiles.git && cd dotfiles && source bootstrap.sh
```

To update, `cd` into your local `dotfiles` repository and then:

```bash
source bootstrap.sh
```

Alternatively, to update while avoiding the confirmation prompt:

```bash
set -- -f; source bootstrap.sh
```

### Git-free install
To install these dotfiles without Git:

```bash
cd; curl -#L https://github.com/glennabaron/dotfiles/tarball/master | tar -xzv --strip-components 1 --exclude={README.md,bootstrap.sh,LICENSE-MIT.txt}
```

To update later on, just run that command again.

### Specify the `$PATH`
If `~/.path` exists, it will be sourced along with the other files, before any feature testing takes place.

Here's an example `~/.path` file that adds `/usr/local/bin` to the `$PATH`:

```bash
export PATH="/usr/local/bin:$PATH"
```

### Add custom commands without creating a new fork
If `~/.extra` exists, it will be sourced along with the other files. You can use this to add a few custom commands without the need to fork this entire repository, or to add commands you don't want to commit to a public repository.

My `~/.extra` looks something like this:

```bash
# Git credentials
# Not in the repository, to prevent people from accidentally committing under my name
GIT_AUTHOR_NAME="Glenna Baron"
GIT_COMMITTER_NAME="$GIT_AUTHOR_NAME"
git config --global user.name "$GIT_AUTHOR_NAME"
GIT_AUTHOR_EMAIL="glennabaron@github.com"
GIT_COMMITTER_EMAIL="$GIT_AUTHOR_EMAIL"
git config --global user.email "$GIT_AUTHOR_EMAIL"
```

### When setting up a new Mac

Don't forget to install the Xcode Command Line tools!
```bash
xcode-select --install
```

### OSX defaults

```bash
./.macos
```

### Install some common [Homebrew](http://brew.sh/) formulae

```bash
./brew.sh
```

### Install Brew Casks

```bash
./cask.sh
```

### Install Global Node Modules

```bash
./npm.sh
```

### Thanks to…
[@troyxmccall](https://github.com/troyxmccall/dotfiles) & [@mathiasbynens](https://github.com/mathiasbynens/dotfiles)
