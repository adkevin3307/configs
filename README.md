# Configs

## Environment

- `zsh >= 5.8`
- `vim >= 8.2`
- `clang-format >= 10.0`

## Usage

- `Ubuntu` users can use `setup.sh` directly
- The last step in `setup.sh` will open `~/.vimrc` and install plugins, after install finish, just use `:qa` to leave

## Key Mapping

List some of useful custom key mappings.

- `<C>`: `Ctrl`
- `<S>`: `Shift`
- `<Leader>`: `\`
- `<CR>`: `Enter`
- `<TAB>`: `Tab`
- `<space>`: `Space`
- `<F2>`: F2 key
- `<F4>`: F4 key
- `<F12>`: F12 key
- `N` / `I` / `V`: Normal / Insert / Visual mode

### vim

|       Key       |    Mode    |               Description               |
| --------------- | ---------- | --------------------------------------- |
| `<C-m>`, `<CR>` | `N` / `I`  | show all the key mappings               |
| `<F2>`          | `N`        | rename selected word                    |
| `<F4>`          | `N`        | auto format                             |
| `<F12>`         | `N`        | goto definition                         |
| `<TAB>`         | `I`        | select next in auto complete prompt     |
| `<S-TAB>`       | `I`        | select previous in auto complete prompt |
| `?`             | `N`        | show documentation on current word      |
| `<C-f>`         | `N` / `I`  | show files                              |
| `<C-g>`         | `N`        | show git commits                        |
| `<C-j>`         | `N` / `I`  | scroll down in documentation            |
| `<C-k>`         | `N` / `I`  | scroll up in documentation              |
| `<C-p>`         | `N` / `I`  | show buffer list                        |
| `<C-q>`         | `N`        | close current buffer                    |
| `<C-t>`         | `N` / `I`  | show tags in current file               |
| `<C-y>`         | `N`        | show yank history                       |
| `<Leader>j`     | `N`        | search in current file                  |
| `<Leader>n`     | `N`        | unset highlight                         |
| `<Leader>cc`    | `N`        | toggle code comment                     |
| `<Leader>gg`    | `N`        | show git change                         |
| `<Leader>gn`    | `N`        | goto next git change                    |
| `<Leader>gp`    | `N`        | goto previous git change                |

### tmux

TODO

## Reference

### zsh

- [oh-my-zsh](https://github.com/ohmyzsh/ohmyzsh)
- [powerlevel9k](https://github.com/Powerlevel9k/powerlevel9k)
- [powerlevel10k](https://github.com/romkatv/powerlevel10k)
- [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)
- [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)

### vim

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

### tmux

- [tmux-plugins/tpm](https://github.com/tmux-plugins/tpm)
- [tmux-plugins/tmux-sensible](https://github.com/tmux-plugins/tumx-sensible)
- [wfxr/tmux-power](https://github.com/wfxr/tmux-power)
- [tmux-plugins/tmux-yank](https://github.com/tmux-plugins/tmux-yank)
- [tmux-plugins/tmux-copycat](https://github.com/tmux-plugins/tmux-copycat)

