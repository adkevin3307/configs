# Configs

## Environment

- `zsh >= 5.8`
- `vim >= 8.2` / `nvim >= 0.9.4`
- `clang-format >= 10.0`

## Usage

- `Ubuntu` users can use `setup.sh` directly
- Remember to open sth. with `editor (vim / nvim)` first, go get a coffee and wait

## Key Mapping

List some of useful custom key mappings.

- `<A>`: `Alt`
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
| `<Leader>f`     | `N`        | search in current file                  |
| `<Leader>n`     | `N`        | unset highlight                         |
| `<Leader>d`     | `N`        | add docstring                           |
| `<Leader>cc`    | `N`        | toggle code comment                     |
| `<Leader>gg`    | `N`        | show git change                         |
| `<Leader>gn`    | `N`        | goto next git change                    |
| `<Leader>gp`    | `N`        | goto previous git change                |

### nvim

|       Key       |    Mode    |               Description               |
| --------------- | ---------- | --------------------------------------- |
| `<F2>`          | `N`        | rename selected word                    |
| `<F4>`          | `N`        | auto format                             |
| `<F12>`         | `N`        | goto definition                         |
| `<TAB>`         | `I`        | select next in auto complete prompt     |
| `<S-TAB>`       | `I`        | select previous in auto complete prompt |
| `?`             | `N`        | show documentation on current word      |
| `<C-f>`         | `N`        | show files                              |
| `<C-g>`         | `N`        | show git commits                        |
| `<C-p>`         | `N`        | show buffer list                        |
| `<C-q>`         | `N`        | close current buffer                    |
| `<C-t>`         | `N`        | show tags in current file               |
| `<C-y>`         | `N`        | show yank history                       |
| `<C-d>`         | `N`        | show diagnostic                         |
| `<C-b>`         | `N`        | open structure tree                     |
| `<Leader>n`     | `N`        | unset highlight                         |
| `<Leader>cc`    | `N`        | toggle code comment                     |
| `<Leader>gg`    | `N`        | show git change                         |
| `<Leader>gn`    | `N`        | goto next git change                    |
| `<Leader>gp`    | `N`        | goto previous git change                |

### tmux

- `<Leader>`: `<C-b>`

|       Key       |          Description          |
| --------------- | ----------------------------- |
| `<S-Up>`        | select up pane                |
| `<S-Down>`      | select down pane              |
| `<S-Left>`      | select left pane              |
| `<S-Right>`     | select right pane             |
| `<Leader>/`     | search in buffer              |

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
- [Yggdroot/indentLine](https://github.com/Yggdroot/indentLine)
- [scrooloose/nerdcommenter](https://github.com/scrooloose/nerdcommenter)
- [vim-python/python-syntax](https://github.com/vim-python/python-syntax)
- [vim-autoformat/vim-autoformat](https://github.com/vim-autoformat/vim-autoformat)
- [ntpeters/vim-better-whitespace](https://github.com/ntpeters/vim-better-whitespace)
- [neoclide/coc.nvim](https://github.com/neoclide/coc.nvim)
- [kkoomen/vim-doge](https://github.com/kkoomen/vim-doge)
- [gelguy/wilder.nvim](https://github.com/gelguy/wilder.nvim)
- [djoshea/vim-autoread](https://github.com/djoshea/vim-autoread)
- [liuchengxu/vim-clap](https://github.com/liuchengxu/vim-clap)
- [sillybun/vim-repl](https://github.com/sillybun/vim-repl)

### nvim

- [navarasu/onedark.nvim](https://github.com/navarasu/onedark.nvim)
- [nvim-lualine/lualine.nvim](https://github.com/nvim-lualine/lualine.nvim)
- [nvim-telescope/telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)
- [nvim-lua/plenary.nvim](https://github.com/nvim-lua/plenary.nvim)
- [gbprod/yanky.nvim](https://github.com/gbprod/yanky.nvim)
- [nvim-telescope/telescope-file-browser.nvim](https://github.com/nvim-telescope/telescope-file-browser.nvim)
- [gelguy/wilder.nvim](https://github.com/gelguy/wilder.nvim)
- [roxma/nvim-yarp](https://github.com/roxma/nvim-yarp)
- [roxma/vim-hug-neovim-rpc](https://github.com/roxma/vim-hug-neovim-rpc)
- [utilyre/barbecue.nvim](https://github.com/utilyre/barbecue.nvim)
- [dstein64/nvim-scrollview](https://github.com/dstein64/nvim-scrollview)
- [lewis6991/gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim)
- [ntpeters/vim-better-whitespace](https://github.com/ntpeters/vim-better-whitespace)
- [lukas-reineke/indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim)
- [nvim-treesitter/nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
- [numToStr/Comment.nvim](https://github.com/numToStr/Comment.nvim)
- [vim-autoformat/vim-autoformat](https://github.com/vim-autoformat/vim-autoformat)
- [stevearc/dressing.nvim](https://github.com/stevearc/dressing.nvim)
- [nvim-tree/nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua)
- [nvim-tree/nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons)
- [folke/todo-comments.nvim](https://github.com/folke/todo-comments.nvim)
- [neovim/nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)
- [williamboman/mason.nvim](https://github.com/williamboman/mason.nvim)
- [williamboman/mason-lspconfig.nvim](https://github.com/williamboman/mason-lspconfig.nvim)
- [hrsh7th/nvim-cmp](https://github.com/hrsh7th/nvim-cmp)
- [neovim/nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)
- [hrsh7th/cmp-nvim-lsp](https://github.com/hrsh7th/cmp-nvim-lsp)
- [hrsh7th/cmp-buffer](https://github.com/hrsh7th/cmp-buffer)
- [hrsh7th/cmp-path](https://github.com/hrsh7th/cmp-path)
- [hrsh7th/cmp-nvim-lsp-signature-help](https://github.com/hrsh7th/cmp-nvim-lsp-signature-help)
- [L3MON4D3/LuaSnip](https://github.com/L3MON4D3/LuaSnip)
- [saadparwaiz1/cmp_luasnip](https://github.com/saadparwaiz1/cmp_luasnip)

### tmux

- [tmux-plugins/tpm](https://github.com/tmux-plugins/tpm)
- [tmux-plugins/tmux-sensible](https://github.com/tmux-plugins/tumx-sensible)
- [wfxr/tmux-power](https://github.com/wfxr/tmux-power)
- [tmux-plugins/tmux-yank](https://github.com/tmux-plugins/tmux-yank)
- [tmux-plugins/tmux-copycat](https://github.com/tmux-plugins/tmux-copycat)

