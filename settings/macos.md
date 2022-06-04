# Config Mac OS

Basic configuration of Mac OS.

## Homebrew

``` bash
xcode-select —-install
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

## Install fzf

```bash
brew install fzf
/usr/local/opt/fzf/install
```

## iTerm2

``` bash
brew cask install iterm2
# TODO
# https://iterm2.com/documentation-dynamic-profiles.html

```

## Oh my shell

``` bash
brew install zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Install plugins and themes
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k

# Config zshrc
sed -i' ' -e 's|ZSH_THEME="robbyrussell"|ZSH_THEME="powerlevel10k/powerlevel10k"|g' ~/.zshrc
sed -i' ' -e 's/ZSH_plugins=(git)/plugins=(git zsh-autosuggestions zsh-syntax-highlighting)\nZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=6"/g' ~/.zshrc

# Install fonts
git clone https://github.com/powerline/fonts.git
cd fonts
./install.sh
cd ..
rm -rf fonts

```

## Visual Studio code

``` bash
brew install --cask visual-studio-code
```
