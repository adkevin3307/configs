#!/bin/bash -e

function prompt()
{
    echo -e "\e[1;32m$*\e[0m"
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

function check_directory()
{
    PWD=$(pwd)

    if [[ -e $PWD/configs/setup.sh ]]; then
        PWD=$PWD/configs
    fi

    if [[ -e $PWD/setup.sh ]]; then
        prompt "Repository Path: $PWD\n"
    else
        prompt "Cannot Find 'setup.py'\n"

        exit 0
    fi
}

function execute()
{
    if [[ $EUID == 0 ]]; then
        eval "$*"
    else
        eval "sudo $*"
    fi
}

get_permission

check_directory

prompt "Basic Update & Upgrade ..."
execute 'apt update'
execute 'apt -y upgrade'
execute 'apt -y autoremove'
prompt "Basic Update & Upgrade Done\n"

prompt "Add vim PPA ..."
execute 'apt install -y software-properties-common'
execute 'add-apt-repository -y ppa:jonathonf/vim'
prompt "Add vim PPA Done\n"

prompt "Install Packages ..."
execute 'apt install -y zsh vim git htop tmux tree curl clang-format clangd python3-pip'
execute 'bash -c "$(curl -fsSL https://deb.nodesource.com/setup_lts.x)"'
execute 'apt install -y nodejs'
execute 'python3 -m pip install black'
prompt "Install Packages Done\n"

prompt "Install oh-my-zsh ..."
rm -vrf ~/.oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" "" --unattended
git clone https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k
git clone https://github.com/zsh-users/zsh-syntax-highlighting ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
cp -vf $PWD/.zshrc ~
cp -vf $PWD/.p10k.zsh ~
prompt "Install oh-my-zsh Done\n"

prompt "Install tmux Plugins ..."
rm -vrf ~/.tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
cp -vf $PWD/.tmux.conf ~
~/.tmux/plugins/tpm/bin/install_plugins
prompt "Install tmux Plugins Done\n"

prompt "Install vim ..."
mkdir -p ~/.vim
cp -vf $PWD/coc-settings.json ~/.vim
cp -vf $PWD/.vimrc ~
vim -E +'PlugInstall --sync'
