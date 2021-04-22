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

    echo ""
    echo ""
}

function execute()
{
    prompt $*

    if [[ $EUID == 0 ]]; then
        $@
    else
        sudo $@
    fi

    echo ""
}

cd $HOME

get_permission

prompt "Basic Update & Upgrade ...\n"
execute apt update
execute apt -y upgrade
execute apt -y autoremove
prompt "Basic Update & Upgrade Done\n"

prompt "Add vim PPA ...\n"
execute apt install -y software-properties-common
execute add-apt-repository -y ppa:jonathonf/vim
execute apt update
prompt "Add vim PPA Done\n"

prompt "Install Packages ...\n"
execute apt install -y zsh vim git htop tmux tree curl clang-format-10 python3-pip

if [[ $EUID == 0 ]]; then
    bash -c "$(curl -fsSL https://deb.nodesource.com/setup_current.x)"
else
    sudo bash -c "$(curl -fsSL https://deb.nodesource.com/setup_current.x)"
fi
echo ""

execute apt install -y nodejs
execute python3 -m pip install autopep8
execute ln -s /usr/bin/clang-format-10 /usr/bin/clang-format
prompt "Install Packages Done\n"

prompt "Install oh-my-zsh ...\n"

if [[ $EUID == 0 ]]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" "" --unattended
else
    sudo sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" "" --unattended
fi
echo ""

execute git clone https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k
execute git clone https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
execute git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
execute cp ~/configs/.zshrc ~
execute cp ~/configs/.p10k.zsh ~
prompt "Install oh-my-zsh Done\n"

prompt "Install tmux Plugins ...\n"
execute git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
execute cp ~/configs/.tmux.conf ~
execute ~/.tmux/plugins/tpm/bin/install_plugins
prompt "Install tmux Plugins Done\n"

prompt "Install vim ...\n"
execute cp ~/configs/.vimrc ~
execute vim ~/.vimrc
prompt "Install vim Done\n"

execute chown -R $(id -nu):$(id -ng) ~
