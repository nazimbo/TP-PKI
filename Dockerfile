FROM httpd:2.4

# Copiez le contenu du site web local dans le répertoire htdocs d'Apache
COPY site/ /usr/local/apache2/htdocs/

# Activez le module SSL (mod_ssl) dans la configuration d'Apache
RUN sed -i 's/#LoadModule\ ssl_module/LoadModule\ ssl_module/' /usr/local/apache2/conf/httpd.conf

# Ajoutez la directive ServerName globalement pour supprimer l'avertissement
RUN echo "ServerName localhost" >> /usr/local/apache2/conf/httpd.conf

# Copiez le certificat et la clé privée dans le répertoire de configuration SSL d'Apache
COPY pki/server.crt /usr/local/apache2/conf/server.crt
COPY pki/server.key /usr/local/apache2/conf/server.key

# Configurez le site virtuel pour utiliser SSL
RUN echo "<VirtualHost *:443>" >> /usr/local/apache2/conf/extra/httpd-ssl.conf
RUN echo "    ServerName localhost" >> /usr/local/apache2/conf/extra/httpd-ssl.conf
RUN echo "    DocumentRoot /usr/local/apache2/htdocs" >> /usr/local/apache2/conf/extra/httpd-ssl.conf
RUN echo "    SSLEngine on" >> /usr/local/apache2/conf/extra/httpd-ssl.conf
RUN echo "    SSLCertificateFile \"/usr/local/apache2/conf/server.crt\"" >> /usr/local/apache2/conf/extra/httpd-ssl.conf
RUN echo "    SSLCertificateKeyFile \"/usr/local/apache2/conf/server.key\"" >> /usr/local/apache2/conf/extra/httpd-ssl.conf
RUN echo "</VirtualHost>" >> /usr/local/apache2/conf/extra/httpd-ssl.conf
