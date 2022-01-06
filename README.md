# Configs

## Environment

- `zsh >= 5.8`
- `vim >= 8.2`
- `clang-format >= 10.0`

## Usage

- Ubuntu use `setup.sh`
    - The last step in `setup.sh` will open `~/.vimrc` and install plugins, after install finish, just use `:qa` to leave

## zsh

- [oh-my-zsh](https://github.com/ohmyzsh/ohmyzsh)
    - `sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"`
- [powerlevel9k](https://github.com/Powerlevel9k/powerlevel9k)
    - `git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k`
- [powerlevel10k](https://github.com/romkatv/powerlevel10k)
    - `git clone https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k`
- [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)
    - `git clone https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting`
- [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)
    - `git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions`

## vim

- [vim-plug](https://github.com/junegunn/vim-plug)
- [joshdick/onedark.vim](https://github.com/joshdick/onedark.vim)
- [vim-airline/vim-airline](https://github.com/vim-airline/vim-airline)
- [vim-airline/vim-airline-themes](https://github.com/vim-airline/vim-airline-themes)
- [scrooloose/nerdtree](https://github.com/scrooloose/nerdtree)
- [Xuyuanp/nerdtree-git-plugin](https://github.com/Xuyuanp/nerdtree-git-plugin)
- [scrooloose/nerdcommenter](https://github.com/scrooloose/nerdcommenter)
- [vim-python/python-syntax](https://github.com/vim-python/python-syntax)
- [neoclide/coc.nvim](https://github.com/neoclide/coc.nvim)
- [lervag/vimtex](https://github.com/lervag/vimtex)
- [voldikss/vim-floaterm](https://github.com/voldikss/vim-floaterm)
- [liuchengxu/vista.vim](https://github.com/liuchengxu/vista.vim)
- [liuchengxu/vim-clap](https://github.com/liuchengxu/vim-clap)
- [ntpeters/vim-better-whitespace](https://github.com/ntpeters/vim-better-whitespace)
- [Chiel92/vim-autoformat](https://github.com/Chiel92/vim-autoformat)
- [Yggdroot/indentLine](https://github.com/Yggdroot/indentLine)
- [gelguy/wilder.nvim](https://github.com/gelguy/wilder.nvim)

## tmux

- [tmux-plugins/tpm](https://github.com/tmux-plugins/tpm)
    - `git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm`
- [tmux-plugins/tmux-sensible](https://github.com/tmux-plugins/tumx-sensible)
- [wfxr/tmux-power](https://github.com/wfxr/tmux-power)
- [tmux-plugins/tmux-yank](https://github.com/tmux-plugins/tmux-yank)
- [tmux-plugins/tmux-copycat](https://github.com/tmux-plugins/tmux-copycat)

## Clang-Format

- Just use `.clang-format`
