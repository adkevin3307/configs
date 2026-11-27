# Configs

> Configs for basic environment

## Requirements

- `zsh >= 5.9`
- `vim >= 8.2` / `nvim >= 0.12.2`
- `tmux >= 3.3`

## Usage

- `Ubuntu` / `Arch` users can use `setup.sh` directly
- Tools not installed by `apt` / `pacman` are put into `~/.local/bin`, e.g. `git-graph`, `track`, `monitor` and latest `tmux` / `nvim` / `fzf` on `Ubuntu`
- After `setup.sh`, remember to open editor `vim / nvim`, then go get a coffee and wait
- Install `HackNerdFont-Regular.ttf` on the machine running the terminal and use it as terminal font for icons
- Warnings: currently, `vim` is suspend, please use `nvim` if possible

## Key Mapping

List some of useful custom key mappings.

- `<A>`: `Alt`
- `<C>`: `Ctrl`
- `<S>`: `Shift`
- `<CR>`: `Enter`
- `<TAB>`: `Tab`
- `<F2>`: F2 key
- `<F4>`: F4 key
- `<F10>`: F10 key
- `<F12>`: F12 key
- `N` / `I` / `V`: Normal / Insert / Visual mode

### vim [SUSPEND]

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

- The `<Leader>` is `<Space>`
- Refer to `<Leader>?` for more information

### tmux

- `<Leader>`: `<C-b>`

|        Key        |          Description          |
| ----------------- | ----------------------------- |
| `<S-Up>`          | select up pane                |
| `<S-Down>`        | select down pane              |
| `<S-Left>`        | select left pane              |
| `<S-Right>`       | select right pane             |
| `<Leader>t`       | tmuxioner for session         |
| `<Leader>\`       | popup window                  |
| `<Leader><C-s>`   | store current session         |
| `<Leader><C-r>`   | restore stored session        |
| `<Leader>T`       | show clock                    |
| `<Leader>?`       | show which-key menu           |
| `<Leader>??`      | for more information          |

## Reference

### zsh

> Check `.zshrc` for more settings and information

- [oh-my-zsh](https://github.com/ohmyzsh/ohmyzsh)
- [powerlevel10k](https://github.com/romkatv/powerlevel10k)
- [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)
- [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)

### vim [SUSPEND]

> Check `.vimrc` for more settings information

### nvim

> Check `lua/plugins/*.lua` for more settings and information

### tmux

> Check `.tmux.conf` and `tmux-which-key.yaml` for more settings and information

- [tmux-plugins/tpm](https://github.com/tmux-plugins/tpm)
- [alexwforsythe/tmux-which-key](https://github.com/alexwforsythe/tmux-which-key)
- [wfxr/tmux-power](https://github.com/wfxr/tmux-power)
- [tmux-plugins/tmux-prefix-highlight](https://github.com/tmux-plugins/tmux-prefix-highlight)
- [tmux-plugins/tmux-sensible](https://github.com/tmux-plugins/tmux-sensible)
- [adkevin3307/tmuxioner](https://github.com/adkevin3307/tmuxioner)
- [omerxx/tmux-floax](https://github.com/omerxx/tmux-floax)
- [tmux-plugins/tmux-resurrect](https://github.com/tmux-plugins/tmux-resurrect)
- [tmux-plugins/tmux-continuum](https://github.com/tmux-plugins/tmux-continuum)

