#!/usr/bin/env bash

# installer tor bridges

mkdir -p ~/.local/bin
cd ~/.local/bin

download files
curl -s -o get-tor-bridges https://raw.githubusercontent.com/MicroRobotProgrammer/TorBridge/master/TorBridges.sh
curl -s -o remove-broken-bridges https://raw.githubusercontent.com/MicroRobotProgrammer/TorBridge/master/RemoveBrokenBridges.sh

chmod +x remove-broken-bridges
chmod +x get-tor-bridges

[[ -z $(echo $PATH|grep $HOME/.local/bin) ]] &&
{
    # shell file config
    shell_file=$HOME/.$(egrep -o "[^/]*$" <<< $SHELL)rc

    # check file exist
    [[ ! -e "$shell_file" ]] && echo -e "\e[31mError cant find shell config!\e[m"

    # automatically add path program to shell config file jsut support bash and zshrc
    [[ ! -z $(egrep "bash|zsh" <<< $shell_file) ]] &&
    {
        # add path run script into PATH variable
        [[ -z $(cat $shell_file|egrep "if \[ -e ~/.local/bin \]; then") ]] &&
        {
            echo "if [ -e ~/.local/bin ]; then" >> $shell_file
            echo "    export PATH=\"\$PATH:\$HOME/.local/bin/\"">> $shell_file
            echo "fi" >> $shell_file
            echo -e "\e[1;32mrun path was added automatically.\e[m"
        } || echo -e "\e[1;32mpath already added.\e[m"
    }||
    {
        # manual installation
        echo -e "\e[1;33mPlease add these lines to your '${SHELL}' config file and continue with manual installation\e[1;35m"
        echo -e "if [ -e ~/.local/bin ]; then"
        echo -e "    export PATH=\"\$PATH:\$HOME/.local/bin/\""
        echo -e "fi"

    }
}

echo -e "\e[1;32mScript installed successfully!\e[m"
