#!/bin/bash

function prompt()
{
    echo ""
    echo -e "\e[1;32m$1\e[0m"
    echo ""
}

function execute()
{
    eval "$1"

    if [[ $? != 0 ]]; then
        echo -e "\e[1;31mExecute $1 Failed\e[0m"

        exit
    fi
}

prompt 'Get Permission ...'
execute 'sudo echo "Done"'

cd $HOME

prompt 'Basic Update & Upgrade ...'
execute 'sudo apt update'
execute 'sudo apt -y upgrade'
execute 'sudo apt -y autoremove'
prompt 'Basic Update & Upgrade Done'

prompt 'Add vim PPA ...'
execute 'sudo apt install -y software-properties-common'
execute 'sudo add-apt-repository -y ppa:jonathonf/vim'
execute 'sudo apt update'
prompt 'Add vim PPA Done'

prompt 'Install Packages ...'
execute 'curl -fsSL https://deb.nodesource.com/setup_current.x | sudo -E bash -'
execute 'sudo apt install -y zsh vim git htop tmux tree curl nodejs clang-format-10 silversearcher-ag python3-pip'
execute 'sudo python3 -m pip install autopep8'
execute 'sudo ln -s /usr/bin/clang-format-10 /usr/bin/clang-format'
prompt 'Install Packages Done'

prompt 'Install oh-my-zsh ...'
execute 'sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" "" --unattended'
execute 'git clone https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k'
execute 'git clone https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting'
execute 'git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions'
execute 'cp configs/.zshrc ~'
execute 'cp configs/.p10k.zsh ~'
prompt 'Install oh-my-zsh Done'

# prompt 'Install vim Plugins ...'
# execute 'curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
# execute 'cp configs/.vimrc ~'
# execute 'vim -c "PlugInstall" -c "qa"'
# execute 'vim -c "CocInstall coc-clangd coc-pyright coc-sh coc-git coc-highlight" -c "qa"'
# prompt 'Install vim Plugins Done'

prompt 'Install tmux Plugins ...'
execute 'git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm'
execute 'cp configs/.tmux.conf ~'
execute '~/.tmux/plugins/tpm/bin/install_plugins'
prompt 'Install tmux Plugins Done'
