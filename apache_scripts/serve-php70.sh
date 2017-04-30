#!/usr/bin/env bash

if [ "$#" -ne 2 ]; then
	echo "Modo de uso: $0 nomedodominio.dev /caminho/para/o/site"
	exit 1;
fi

sudo mkdir /etc/apache2/ssl 2>/dev/null

PATH_SSL="/etc/apache2/ssl"
PATH_KEY="${PATH_SSL}/${1}.key"
PATH_CSR="${PATH_SSL}/${1}.csr"
PATH_CRT="${PATH_SSL}/${1}.crt"

if [ ! -f $PATH_KEY ] || [ ! -f $PATH_CSR ] || [ ! -f $PATH_CRT ]
then
  sudo openssl genrsa -out "$PATH_KEY" 2048 2>/dev/null
  sudo openssl req -new -key "$PATH_KEY" -out "$PATH_CSR" -subj "/CN=$1/O=Vagrant/C=UK" 2>/dev/null
  sudo openssl x509 -req -days 365 -in "$PATH_CSR" -signkey "$PATH_KEY" -out "$PATH_CRT" 2>/dev/null
fi

block="
<VirtualHost *:80>
	ServerName $1
    ServerAlias www.$1
	DocumentRoot $2

	SetEnv MAGE_IS_DEVELOPER_MODE 1
	<Directory $2>
		AllowOverride all
		Require all granted
	</Directory>

	DirectoryIndex index.php index.htm index.html
	Include conf-available/php7.0-fpm.conf

	#LogLevel info ssl:warn

	ErrorLog ${APACHE_LOG_DIR}/error.log
	CustomLog ${APACHE_LOG_DIR}/access.log combined

	# For most configuration files from conf-available/, which are
	# enabled or disabled at a global level, it is possible to
	# include a line for only one particular virtual host. For example the
	# following line enables the CGI configuration for this host only
	# after it has been globally disabled with "a2disconf".
	#Include conf-available/serve-cgi-bin.conf
</VirtualHost>

<VirtualHost *:443>
	ServerName $1
    ServerAlias www.$1
	DocumentRoot $2

	Protocols h2 http/1.1
	SSLEngine on
    SSLCertificateFile      $PATH_CRT
    SSLCertificateKeyFile $PATH_KEY

	SetEnv MAGE_IS_DEVELOPER_MODE 1
	<Directory $2>
		AllowOverride all
		Require all granted
	</Directory>

	DirectoryIndex index.php index.htm index.html
	#<IfModule proxy_module>
	#    ProxyPassMatch ^/(.*\.php(/.*)?)$ unix:/run/php/php5.6-fpm.sock|fcgi://127.0.0.1:9000/home/robinson/dev/www/
	#</IfModule>
	Include conf-available/php7.0-fpm.conf

	#LogLevel info ssl:warn

	ErrorLog ${APACHE_LOG_DIR}/error.log
	CustomLog ${APACHE_LOG_DIR}/access.log combined

	# For most configuration files from conf-available/, which are
	# enabled or disabled at a global level, it is possible to
	# include a line for only one particular virtual host. For example the
	# following line enables the CGI configuration for this host only
	# after it has been globally disabled with "a2disconf".
	#Include conf-available/serve-cgi-bin.conf
</VirtualHost>
"

echo "$block" | sudo tee "/etc/apache2/sites-available/$1.conf"
echo "127.0.0.1 $1" | sudo tee -a /etc/hosts

sudo a2ensite $1
sudo systemctl restart apache2
