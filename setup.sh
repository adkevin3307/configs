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

        exit 0
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
            execute 'apt install -y zsh git bat htop tmux tree curl unzip fd-find ripgrep python3-pip python3-venv gnupg ca-certificates'
            execute 'ln -s $(which batcat) /usr/bin/bat'

            execute 'mkdir -p /etc/apt/keyrings'
            curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key > nodesource-repo.gpg.key
            execute 'gpg -o /etc/apt/keyrings/nodesource.gpg --dearmor nodesource-repo.gpg.key'
            rm nodesource-repo.gpg.key
            echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_20.x nodistro main" > nodesource.list
            execute 'mv nodesource.list /etc/apt/sources.list.d/nodesource.list'
            execute 'apt update'
            execute 'apt install -y nodejs'

            ;;
        arch)
            execute 'pacman -S zsh git bat btop tmux tree curl unzip fd ripgrep python-pip python-virtualenv nodejs npm --noconfirm'

            ;;
        *)
            ;;
    esac

    prompt "Install Packages Done\n"
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
    DIRECTORY=$1

    prompt "Install tmux Plugins ..."

    rm -vrf ~/.tmux
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    cp -vf $DIRECTORY/.tmux.conf ~
    ~/.tmux/plugins/tpm/bin/install_plugins

    prompt "Install tmux Plugins Done\n"
}

function install_editor()
{
    OS=$1
    DIRECTORY=$2
    EDITOR=$3

    prompt "Install $EDITOR ..."

    case $EDITOR in
        vim)
            case $OS in
                ubuntu)
                    execute 'apt install -y software-properties-common'
                    execute 'add-apt-repository -y ppa:jonathonf/vim'
                    execute 'apt update'
                    execute 'apt install -y vim'

                    ;;
                arch)
                    execute 'pacman -S vim --noconfirm'

                    ;;
                *)
                    ;;
            esac

            mkdir -p ~/.vim
            cp -vf $DIRECTORY/coc-settings.json ~/.vim
            cp -vf $DIRECTORY/.vimrc ~

            ;;
        nvim)
            case $OS in
                ubuntu)
                    curl -LO https://github.com/neovim/neovim/releases/download/stable/nvim.appimage
                    chmod u+x nvim.appimage
                    ./nvim.appimage --appimage-extract
                    execute 'mv squashfs-root /'
                    execute 'ln -s /squashfs-root/AppRun /usr/bin/nvim'
                    execute 'python3 -m pip install pynvim'

                    ;;
                arch)
                    execute 'pacman -S neovim python-pynvim --noconfirm'

                    ;;
                *)
                    ;;
            esac

            mkdir -p ~/.config/nvim
            cp -vf $DIRECTORY/init.lua ~/.config/nvim
            cp -vrf $DIRECTORY/lua ~/.config/nvim

            ;;
        *)
            ;;
    esac

    prompt "Copy $EDITOR Settings Done, Remember to RUN $EDITOR to Finish Install\n"
}

while [[ $# -gt 0 ]]; do
    KEY=$1

    case $1 in
        -e|--editor)
            EDITOR=$2

            shift
            shift
            ;;
        *)
            shift
            ;;
    esac
done

if [[ -z $EDITOR ]]; then
    prompt "Set default editor to nvim ..."

    EDITOR="nvim"
fi

if [[ $EDITOR != "vim" && $EDITOR != "nvim" ]]; then
    prompt "Editor $EDITOR not defined\n"

    exit 0
fi

DIRECTORY=$(check_directory)
OS=$(check_os)

prompt "Repository Path: $DIRECTORY, OS: $OS\n"

get_permission
basic_update_upgrade $OS
install_packages $OS

install_omz $DIRECTORY
install_tmux $DIRECTORY
install_editor $OS $DIRECTORY $EDITOR
