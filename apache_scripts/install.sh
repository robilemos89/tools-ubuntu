#!/bin/bash
# Verifica se já existe a pasta bin na pasta do usuário
if [ ! -d "$HOME/bin" ]; then
    mkdir -p $HOME/bin
    echo PATH=$HOME/bin:$PATH >> ~/.bashrc

    # Se tem o zsh como shell, também adicione o PATH atualizado
    if [ -f "$HOME/.zshrc" ]; then
        echo PATH=$HOME/bin:$PATH >> ~/.zshrc
    fi
fi

# Rodar o script que irá corrigir os domínios .dev com o dnsmasq
if [ -f "fix-dev.sh" ]; then
    chmod +x fix-dev.sh
    sudo ./fix-dev.sh
fi

# Um script para ajudar a arrumar permissões para o grupo www-data possa acessar os dados
# dentro do diretório do usuário.
if [ -f "fix-perms.sh" ]; then
    cp fix-perms.sh $HOME/bin
    ln -sf $HOME/bin/fix-perms.sh $HOME/bin/fix-perms
fi

# Script para criar um VirtualHost, com certificado, utilizando PHP 5.6
if [ -f "serve-php56.sh" ]; then
    cp serve-php56.sh $HOME/bin
    ln -sf $HOME/bin/serve-php56.sh $HOME/bin/serve-php56
fi

# Script para criar um VirtualHost, com certificado, utilizando PHP 7.0
if [ -f "serve-php70.sh" ]; then
    cp serve-php70.sh $HOME/bin
    ln -sf $HOME/bin/serve-php70.sh $HOME/bin/serve-php70
fi

# Script para criar um VirtualHost, com certificado, utilizando PHP 7.1
if [ -f "serve-php71.sh" ]; then
    cp serve-php71.sh $HOME/bin
    ln -sf $HOME/bin/serve-php71.sh $HOME/bin/serve-php71
fi

