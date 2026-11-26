#!/bin/bash -e

function prompt()
{
    echo -e "\e[1;32m$*\e[0m"
}

function execute()
{
    if [[ $EUID == 0 ]]; then
        eval "$*"
    else
        eval "sudo $*"
    fi
}

function check_os()
{
    source /etc/os-release
    OS=$ID

    echo $OS
}

function check_directory()
{
    DIRECTORY=$(pwd)

    if [[ -e $DIRECTORY/configs/setup.sh ]]; then
        DIRECTORY=$DIRECTORY/configs
    fi

    if [[ ! -e $DIRECTORY/setup.sh ]]; then
        prompt "Cannot Find 'setup.sh'\n"

        exit 1
    fi

    echo $DIRECTORY
}

function get_permission()
{
    if [[ $EUID == 0 ]]; then
        prompt "Run as super user ..."
    else
        prompt "Run as $(whoami) ..."

        prompt "Get Permission ..."
        sudo printf ""
        prompt "Get Permission Done"
    fi
}

function basic_update_upgrade()
{
    OS=$1

    prompt "Basic Update & Upgrade ..."

    case $OS in
        ubuntu)
            execute 'apt update'
            execute 'apt -y upgrade'
            execute 'apt -y autoremove'

            ;;
        arch)
            execute 'pacman -Syyuu --noconfirm'
            execute 'pacman -Scc --noconfirm'

            ;;
        *)
            ;;
    esac

    prompt "Basic Update & Upgrade Done\n"
}

function install_packages()
{
    OS=$1

    prompt "Install Packages ..."

    case $OS in
        ubuntu)
            execute 'apt install -y zsh gcc git bat fzf btop tree wget curl direnv diffutils unzip fd-find ripgrep python3-pip python3-venv gnupg ca-certificates'
            execute 'ln -sf $(which batcat) /usr/bin/bat'

            execute 'mkdir -vp /etc/apt/keyrings'
            curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key > nodesource-repo.gpg.key
            execute 'gpg --yes -o /etc/apt/keyrings/nodesource.gpg --dearmor nodesource-repo.gpg.key'
            rm nodesource-repo.gpg.key
            echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_24.x nodistro main" > nodesource.list
            execute 'mv nodesource.list /etc/apt/sources.list.d/nodesource.list'
            execute 'apt update'
            execute 'apt install -y nodejs'

            curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
            source ~/.cargo/env

            ;;
        arch)
            execute 'pacman -S --needed zsh gcc git bat fzf btop tree wget curl direnv diffutils unzip fd ripgrep python-pip python-virtualenv nodejs npm rust --noconfirm'

            ;;
        *)
            ;;
    esac

    prompt "Install Packages Done\n"
}

function install_tools()
{
    prompt "Install Tools ..."

    mkdir -vp ~/.local/bin

    for TOOL in git-graph track monitor; do
        cargo install --locked --git https://github.com/adkevin3307/$TOOL --root ~/.local
    done

    prompt "Install Tools Done\n"
}

function install_omz()
{
    DIRECTORY=$1

    prompt "Install oh-my-zsh ..."

    rm -vrf ~/.oh-my-zsh
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" "" --unattended
    git clone https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k
    git clone https://github.com/zsh-users/zsh-syntax-highlighting ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
    git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
    cp -vf $DIRECTORY/.zshrc ~
    cp -vf $DIRECTORY/.p10k.zsh ~

    prompt "Install oh-my-zsh Done\n"
}

function install_tmux()
{
    OS=$1
    DIRECTORY=$2

    prompt "Install tmux ..."

    case $OS in
        ubuntu)
            execute 'apt install -y libevent-dev libncurses-dev pkg-config bison make'

            TMUX_VERSION=$(basename $(curl -fsSLI -o /dev/null -w '%{url_effective}' https://github.com/tmux/tmux/releases/latest))
            curl -fLO https://github.com/tmux/tmux/releases/download/${TMUX_VERSION}/tmux-${TMUX_VERSION}.tar.gz
            tar -xzf tmux-${TMUX_VERSION}.tar.gz
            cd tmux-${TMUX_VERSION}
            ./configure --prefix=$HOME/.local
            make
            make install
            cd ..
            rm -rf tmux-${TMUX_VERSION} tmux-${TMUX_VERSION}.tar.gz

            ;;
        arch)
            execute 'pacman -S --needed tmux --noconfirm'

            ;;
        *)
            ;;
    esac

    rm -vrf ~/.tmux
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    cp -vf $DIRECTORY/.tmux.conf ~
    ~/.tmux/plugins/tpm/bin/install_plugins

    prompt "Install tmux Done\n"
}

function install_editor()
{
    OS=$1
    DIRECTORY=$2
    TARGET_EDITOR=$3

    prompt "Install $TARGET_EDITOR ..."

    case $TARGET_EDITOR in
        vim)
            case $OS in
                ubuntu)
                    execute 'apt install -y vim'

                    ;;
                arch)
                    execute 'pacman -S --needed vim --noconfirm'

                    ;;
                *)
                    ;;
            esac

            mkdir -vp ~/.vim
            cp -vf $DIRECTORY/coc-settings.json ~/.vim
            cp -vf $DIRECTORY/.vimrc ~

            ;;
        nvim)
            case $OS in
                ubuntu)
                    curl -fLO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
                    mkdir -vp ~/.local/bin ~/.local/opt
                    rm -rf ~/.local/opt/nvim-linux-x86_64
                    tar -xzf nvim-linux-x86_64.tar.gz -C ~/.local/opt
                    rm nvim-linux-x86_64.tar.gz
                    ln -sf ~/.local/opt/nvim-linux-x86_64/bin/nvim ~/.local/bin/nvim
                    execute 'apt install -y python3-pynvim'
                    cargo install --locked tree-sitter-cli --root ~/.local

                    ;;
                arch)
                    execute 'pacman -S --needed neovim python-pynvim tree-sitter-cli --noconfirm'

                    ;;
                *)
                    ;;
            esac

            mkdir -vp ~/.config/nvim
            cp -vf $DIRECTORY/init.lua ~/.config/nvim
            cp -vrf $DIRECTORY/lua ~/.config/nvim

            ;;
        *)
            ;;
    esac

    prompt "Copy $TARGET_EDITOR Settings Done, Remember to RUN $TARGET_EDITOR to Finish Install\n"
}

while [[ $# -gt 0 ]]; do
    KEY=$1

    case $1 in
        -e|--editor)
            TARGET_EDITOR=$2

            shift
            shift
            ;;
        *)
            shift
            ;;
    esac
done

if [[ -z $TARGET_EDITOR ]]; then
    prompt "Set default editor to nvim ..."

    TARGET_EDITOR="nvim"
fi

if [[ $TARGET_EDITOR != "vim" && $TARGET_EDITOR != "nvim" ]]; then
    prompt "Editor $TARGET_EDITOR not defined\n"

    exit 1
fi

DIRECTORY=$(check_directory)
OS=$(check_os)
PATH="$HOME/.local/bin:$PATH"

prompt "Repository Path: $DIRECTORY, OS: $OS\n"

get_permission
basic_update_upgrade $OS

install_packages $OS
install_tools

install_omz $DIRECTORY
install_tmux $OS $DIRECTORY

install_editor $OS $DIRECTORY $TARGET_EDITOR
