# Minha configuração base do Ubuntu
Estes passos foram seguidos em cima do Ubuntu 16.04.2. Escolhi uma versão LTS para trabalhar por conta da estabilidade e confiabilidade da base, fora que o mesmo é utilizado em VPS e em Cloud, facilitando um pouco a vida para o aprendizado na implementação de alguma funcionalidade nestes ambientes.

Os passos a seguir, são aplicados a todos os flavours do Ubuntu. Pode ser o próprio Ubuntu com Unity, Gnome, Xubuntu, Lubuntu, não importa.

Para começo de conversa, após a instalação do Ubuntu, abra o terminal (procure por terminal no menu, ou simplesmente, Ctrl+Alt+T), e rode estes comandos para atualizar a lista de pacotes iniciais, e atualizar o sistema:
```
$ sudo apt update && sudo apt dist-upgrade -y
```

1. Instalação inicial
Instalação de alguns aplicativos básicos que considero essenciais no dia-a-dia.
```
$ sudo apt-get install vim zsh git
```

Configurar os repositórios
```
$ wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
$ sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
$ wget -O - wget https://repos.wine-staging.com/wine/Release.key | sudo apt-key add
$ wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -
$ sudo apt-add-repository 'https://dl.winehq.org/wine-builds/ubuntu/'
$ sudo add-apt-repository -y ppa:libreoffice/ppa
$ sudo add-apt-repository -y ppa:git-core/ppa
$ sudo add-apt-repository -y ppa:caffeine-developers/ppa
$ sudo add-apt-repository -y ppa:webupd8team/java
$ sudo add-apt-repository -y ppa:videolan/stable-daily
$ sudo add-apt-repository "deb http://download.virtualbox.org/virtualbox/debian xenial contrib"
```

Atualizar a lista de pacotes dos repositórios, e instalar o Google Chrome, LibreOffice mais recente, Wine e outros...
```
$ sudo apt update && sudo apt dist-upgrade -y && sudo apt install -y google-chrome-stable wine-staging wine-staging-compat wine-gecko2.21 wine-mono0.0.8 winetricks unity-tweak-tool caffeine openssl curl sqlite3 libsqlite3-dev oracle-java8-installer oracle-java8-set-default vlc virtualbox-5.1 parcellite meld ttf-mscorefonts-installer ruby ruby-dev
```

O VirtualBox foi instalado junto nesta leva. É necessário o passo a seguir para adicionar a permissão ao seu usuário para usá-lo. Para isso, digite:
```
$ sudo gpasswd -a `whoami` vboxusers
```

O Google Chrome estraga a lista de repositórios quando instalado, enchendo de erros as informações do APT. Para consertar, faça:
```
$ sudo rm /etc/apt/sources.list.d/google.list*
$ sudo apt-update
```

Você precisa configurar o git para utilizar as suas informações. Para isso (LEIA COM ATENÇÃO OS COMANDOS A SEGUIR, E FAÇA A ADAPTAÇÃO NECESSÁRIA PARA SEU CASO), use:
```
$ git config --global user.email "seuemail@coloqueaqui.com"
$ git config --global user.name "Seu Nome Aqui"
```

2. Skype, shutter, recordmyscreen, oh-my-zsh, fontes e preferências pessoais
### Instalação do Skype
```
$ dpkg -s apt-transport-https > /dev/null || bash -c "sudo apt-get update; sudo apt-get install apt-transport-https -y" 
$ curl https://repo.skype.com/data/SKYPE-GPG-KEY | sudo apt-key add - 
$ echo "deb [arch=amd64] https://repo.skype.com/deb stable main" | sudo tee /etc/apt/sources.list.d/skype-stable.list 
$ sudo apt-get update 
$ sudo apt-get install skypeforlinux -y 
```

### Instalação do Shutter (aplicativo de screenshots)
```
$ sudo add-apt-repository -y ppa:shutter/ppa
$ sudo apt update && sudo apt install -y shutter
```

### Instalação do Spotify
```
$ sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys BBEBDCB318AD50EC6865090613B00F1FD2C19886
$ echo deb http://repository.spotify.com stable non-free | sudo tee /etc/apt/sources.list.d/spotify.list
$ sudo apt update && sudo apt install -y spotify-client
```

### Gosto de utilizar o oh-my-zsh em conjunto com o shell ZSH. Para isto, basta seguir estes passos:
```
$ sudo apt install -y zsh
$ sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
```
Em certo momento, você terá que digitar a sua senha de usuário para confirmar a troca de shell. Após, é só deslogar e logar novamente.

### O meu terminal favorito é o Terminator, para abrir janelas de console lado-a-lado.
```
$ sudo apt install -y terminator
```

### Gosto de usar a distribuição SPF13 do editor vim. Para instalá-lo, rode:
```
$ curl http://j.mp/spf13-vim3 -L -o - | sh
```

### Também uso o pacote de fontes Powerline. Só precisa seguir os passos de acordo com o que é demonstrado em sua página do Github:
```
$ git clone https://github.com/powerline/fonts.git
$ cd fonts
$ ./install.sh
$ cd ..
$ rm -rf fonts
```

### Instalação de alguns pacotes de ícones
```
$ sudo add-apt-repository -y ppa:moka/daily
$ sudo apt update && sudo apt install -y moka-icon-theme faba-icon-theme faba-mono-icons
```

3. Instalação das ferramentas de desenvolvimento
### Criar uma pasta para conter scripts e outros no diretório do usuário atual
```
$ mkdir -p $HOME/bin
```

Se você optou por instalar o ZSH, atualize o PATH com o comando:
```
$ echo PATH=$HOME/bin:$PATH >> ~/.zshrc
$ source ~/.zshrc
```

Caso contrário, rode:
```
$ echo PATH=$HOME/bin:$PATH >> ~/.bashrc
$ source ~/.zshrc
```

### Baixar o último FileZilla disponível para o Ubuntu 16.04
```
$ sudo sh -c 'echo "deb http://archive.getdeb.net/ubuntu xenial-getdeb apps" >> /etc/apt/sources.list.d/getdeb.list'
$ wget -q -O - http://archive.getdeb.net/getdeb-archive.key | sudo apt-key add -
& sudo apt update && sudo apt install -y filezilla
```

### Instalar o Ubuntu Make
```
$ sudo add-apt-repository -y ppa:ubuntu-desktop/ubuntu-make
$ sudo apt-get update && sudo apt-get install -y ubuntu-make
```

### Instalar o Sublime Text (se preferível)
```
$ umake ide sublime-text ~/Programas/sublime-text
```

### Instalar o Visual Studio Code (se preferível)
```
$ curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
$ sudo mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg
$ sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
$ sudo apt update && sudo apt install -y code
```

### Instalar o PHPStorm (se preferível)
```
$ umake ide phpstorm ~/Programas/phpstorm
```

### Instalar o NVM e a última versão disponível do NodeJS
```
$ curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.1/install.sh | bash
```

E conforme sugestão do instalador, terá que inserir os dados de configurações no arquivo .bashrc ou .zshrc, de acordo com o seu shell. Se você optou pelo bash, rode:
```
$ echo 'export NVM_DIR="$HOME/.nvm"' >> ~/.bashrc
$ echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm' >> ~/.bashrc
$ source ~/.bashrc
```

Se optou pelo zsh, rode:
```
$ echo 'export NVM_DIR="$HOME/.nvm"' >> ~/.zshrc
$ echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm' >> ~/.zshrc
$ source ~/.zshrc
```

Para completar a instalação, use este comando para baixar a última versão da série 7:
```
$ nvm i 7
```

Se preferir uma outra versão em específico, especifique:
```
$ nvm i 6.10.2
```

Também aconselho a instalar o yarn, bower, gulp-cli, aproveitando o passo:
```
$ npm -g i yarn gulp-cli bower yo generator-webapp 
```

## Instalar o último PHP disponível
```
$ sudo add-apt-repository -y ppa:ondrej/php
$ sudo apt update && sudo apt-get dist-upgrade -y && sudo apt-get install -y php7.1-bcmath php7.1-bz2 php7.1-curl php7.1-dev php7.1-enchant php7.1-fpm php7.1-gd php7.1-gmp php7.1-imap php7.1-intl php7.1-json php7.1-ldap php7.1-mbstring php7.1-mcrypt php7.1-mysql php7.1-odbc php7.1-opcache php7.1-pgsql php7.1-pspell php7.1-readline php7.1-soap php7.1-sqlite3 php7.1-tidy php7.1-xml php7.1-xmlrpc php7.1-xsl php7.1-zip
```

Se preferível instalar o PHP 7.0, rode isto também:
```
$ sudo apt install -y php7.0-bcmath php7.0-bz2 php7.0-curl php7.0-dev php7.0-enchant php7.0-fpm php7.0-gd php7.0-gmp php7.0-imap php7.0-intl php7.0-json php7.0-ldap php7.0-mbstring php7.0-mcrypt php7.0-mysql php7.0-odbc php7.0-opcache php7.0-pgsql php7.0-pspell php7.0-readline php7.0-soap php7.0-sqlite3 php7.0-tidy php7.0-xml php7.0-xmlrpc php7.0-xsl php7.0-zip
```

Se quiser o PHP 5.6, rode isto (após a instalação do 7.1):
```
$ sudo apt-get install -y php5.6-bcmath php5.6-bz2 php5.6-curl php5.6-dev php5.6-enchant php5.6-fpm php5.6-gd php5.6-gmp php5.6-imap php5.6-intl php5.6-json php5.6-ldap php5.6-mbstring php5.6-mcrypt php5.6-mysql php5.6-odbc php5.6-opcache php5.6-pgsql php5.6-pspell php5.6-readline php5.6-soap php5.6-sqlite3 php5.6-tidy php5.6-xml php5.6-xmlrpc php5.6-xsl php5.6-zip
```

Por último, na instalação do(s) PHP(s), sugiro instalar o Xdebug para ajudar na depuração dos códigos:
```
$ sudo apt install -y php-xdebug
```

Aproveitando o passo de instalação do PHP, sugiro a instalação das ferramentas de linha de comando, como o composer, wp-cli, n98-magerun, laravel, symfony e outros...
```
$ cd ~/bin
$ wget https://getcomposer.org/composer.phar && chmod +x composer.phar && ln -s composer.phar composer
$ curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && chmod +x wp-cli.phar && ln -s wp-cli.phar wp
$ curl -O https://files.magerun.net/n98-magerun.phar && chmod +x n98-magerun.phar && ln -s n98-magerun.phar magerun
$ composer global require "laravel/installer"
$ echo PATH=$HOME/.config/composer/vendor/bin:$PATH >> ~/.zshrc && echo PATH=$HOME/.config/composer/vendor/bin:$PATH >> ~/.bashrc
$ curl -LsS https://symfony.com/installer -o symfony && chmod +x symfony
```

## Apache
Vamos instalar o último Apache disponível
```
$ sudo add-apt-repository -y ppa:ondrej/apache2
$ sudo apt update && sudo apt install -y apache2
$ sudo a2enmod rewrite headers ssl proxy_fcgi http2
```

Acompanha este guia dois arquivos para automatizar a configuração do Apache para os domínios de desenvolvimento: serve-php56.sh e serve-php70.sh, que irão criar domínios com certificados de segurança. Eles se encontram na pasta ```apache_scripts```

## SoapUI
```
$ wget -O /tmp/soapui.sh https://b537910400b7ceac4df0-22e92613740a7dd1247910134033c0d1.ssl.cf5.rackcdn.com/soapui/5.3.0/SoapUI-x64-5.3.0.sh
$ chmod +x /tmp/soapui.sh
$ /tmp/soapui.sh -q -dir ~/Programas/soapui
$ cd ~ && rm -rf WSDL-WADL Sample-* popular-apis
$ cp Programas/soapui/SoapUI-5.3.0.desktop ~/.local/share/applications/
```

### Os próximos passos ficam por conta do freguês, se quer usar o MySQL ou o MariaDB
## Instalar o MySQL e MySQL Workbench
```
$ wget -O /tmp/mysql-apt.deb https://dev.mysql.com/get/mysql-apt-config_0.8.4-1_all.deb
$ sudo dpkg -i /tmp/mysql-apt.deb
```
No assistente que se apresenta, é só dar Ok que já estará tudo certo. Após:
```
$ sudo apt update && sudo apt install -y mysql-server mysql-workbench
```

Se você não colocar uma senha de root durante a instalação, siga estes passos:
1. Entre no console do MySQL como root usando sudo:
```
$ sudo mysql -u root
```
2. Dentro do console do MySQL, digite os seguintes comandos:
```
update mysql.user set plugin = 'mysql_native_password' where User='root';
flush privileges;
```
3. Digite: ```\q``` para sair do console do MySQL.

Com isso será possível logar no MySQL como root sem precisar ser root. Tem uma explicação melhor no Stack Overflow, neste [link](https://askubuntu.com/questions/766334/cant-login-as-mysql-user-root-from-normal-user-account-in-ubuntu-16-04).

## Instalar o MariaDB
```
$ sudo apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xF1656F24C74CD1D8
$ sudo add-apt-repository 'deb [arch=amd64,i386,ppc64el] http://mirror.ufscar.br/mariadb/repo/10.1/ubuntu xenial main'
$ sudo apt update && sudo apt install -y mariadb-server
```

## Instalar o HeidiSQL
```
$ wget -O /tmp/heidisql.exe https://www.heidisql.com/installers/HeidiSQL_9.4.0.5125_Setup.exe
$ WINEARCH=win32 wine wineboot --init
$ wine /tmp/heidisql.exe
```

4. Ajustes no sistema
## Ajustando o parâmetro max_user_watches
As IDEs da JetBrains sempre dão o aviso em algum ponto que o max_user_watches são de valor muito baixo. Para corrigir, de acordo com a documentação da JetBrains, faça isto:
```
$ echo "fs.inotify.max_user_watches = 524288" | sudo tee -a /etc/sysctl.d/99-idea.conf
$ sudo sysctl --system -p
```
