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

function check_directory()
{
    PWD=$(pwd)

    if [[ -e $PWD/configs/setup.sh ]]; then
        PWD=$PWD/configs
    fi

    if [[ ! -e $PWD/setup.sh ]]; then
        prompt "Cannot Find 'setup.sh'\n"

        exit 0
    fi

    echo $PWD
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
    prompt "Basic Update & Upgrade ..."
    execute 'apt update'
    execute 'apt -y upgrade'
    execute 'apt -y autoremove'
    prompt "Basic Update & Upgrade Done\n"
}

function install_packages()
{
    prompt "Install Packages ..."

    execute 'apt install -y zsh git htop tmux tree curl unzip ripgrep ca-certificates gnupg clang-format clangd python3-pip'

    execute 'apt install -y bat'
    execute 'ln -s $(which batcat) /usr/bin/bat'

    execute 'mkdir -p /etc/apt/keyrings'
    curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key > nodesource-repo.gpg.key
    execute 'gpg -o /etc/apt/keyrings/nodesource.gpg --dearmor nodesource-repo.gpg.key'
    rm nodesource-repo.gpg.key
    echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_20.x nodistro main" > nodesource.list
    execute 'mv nodesource.list /etc/apt/sources.list.d/nodesource.list'
    execute 'apt update'
    execute 'apt install -y nodejs'

    execute 'python3 -m pip install black'

    prompt "Install Packages Done\n"
}

function install_omz()
{
    PWD=$1

    prompt "Install oh-my-zsh ..."
    rm -vrf ~/.oh-my-zsh
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" "" --unattended
    git clone https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k
    git clone https://github.com/zsh-users/zsh-syntax-highlighting ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
    git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
    cp -vf $PWD/.zshrc ~
    cp -vf $PWD/.p10k.zsh ~
    prompt "Install oh-my-zsh Done\n"
}

function install_tmux()
{
    PWD=$1

    prompt "Install tmux Plugins ..."
    rm -vrf ~/.tmux
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    cp -vf $PWD/.tmux.conf ~
    ~/.tmux/plugins/tpm/bin/install_plugins
    prompt "Install tmux Plugins Done\n"
}

function install_editor()
{
    PWD=$1
    EDITOR=$2

    prompt "Install $EDITOR ..."
    execute 'apt install -y software-properties-common'

    if [[ $EDITOR == "VIM" ]]; then
        execute 'add-apt-repository -y ppa:jonathonf/vim'
        execute 'apt update'
        execute 'apt install -y vim'

        mkdir -p ~/.vim
        cp -vf $PWD/coc-settings.json ~/.vim
        cp -vf $PWD/.vimrc ~

        # vim -E +'PlugInstall --sync'
    elif [[ $EDITOR == "NVIM" ]]; then
        curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
        chmod u+x nvim.appimage
        ./nvim.appimage --appimage-extract
        execute 'mv squashfs-root /'
        execute 'ln -s /squashfs-root/AppRun /usr/bin/nvim'

        mkdir -p ~/.config/nvim
        cp -vf $PWD/coc-settings.json ~/.config/nvim
        cp -vf $PWD/init.lua ~/.config/nvim
        cp -vrf $PWD/lua ~/.config/nvim

        # nvim -E +'PlugInstall --sync'
    fi

    prompt "Copy $EDITOR Settings Done, Need Install Custom\n"
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
    prompt "Set default editor to VIM ..."

    EDITOR="VIM"
fi

if [[ $EDITOR != "VIM" && $EDITOR != "NVIM" ]]; then
    prompt "Editor $EDITOR not defined\n"

    exit 0
fi

PWD=$(check_directory)
prompt "Repository Path: $PWD\n"

get_permission
basic_update_upgrade
install_packages

install_omz $PWD
install_tmux $PWD
install_editor $PWD $EDITOR
