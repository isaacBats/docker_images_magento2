#!/bin/bash
COLOR='\033[0;35m'
NC='\033[0m'
file="/var/www/html/bin/magento"
if [ -f "$file" ]
then
	echo -e "${COLOR}Magento ya está instalado."
else
	echo -e "${COLOR}Obteniendo Magento2..."
	cd /var/www/html
	composer create-project --repository-url=https://repo.magento.com/ magento/project-community-edition="MAGENTO_VERSION" ./
	composer config secure-http false
	composer config minimum-stability beta
	composer install
	echo -e "${COLOR}Instalando Magento2..."
	php bin/magento setup:install --admin-firstname=pengo --admin-lastname=admin --admin-email=$MAGENTO_ADMIN_EMAIL --admin-user=$MAGENTO_ADMIN_USER --admin-password=$MAGENTO_ADMIN_PASSWORD --db-host=$MAGENTO_DB_HOST --db-name=$MAGENTO_DB_NAME --db-user=$MAGENTO_DB_USERNAME --db-password=$MAGENTO_DB_PASSWORD --currency=$MAGENTO_CURRENCY --timezone=$MAGENTO_TIMEZONE --language=$MAGENTO_LANGUAGE --base-url=$MAGENTO_BASE_URL --backend-frontname=$MAGENTO_BACKEND_FRONTNAME
	echo -e "${COLOR}Instalando Humboldt..."
	composer config repositories.humboldt composer http://staging.pengostores.mx:5000
	composer require pengo/humboldt
	composer require pengo/backendtheme
	cp /root/.composer/auth.json ./auth.json
	chown root:www-data /var/www/html -Rf
	echo -e "${COLOR}Activando Humboldt..."
	php bin/magento module:enable Pengo_Humboldt
	php bin/magento setup:upgrade
	php bin/magento setup:di:compile
	find . -type d -exec chmod 770 {} \; &&  find . -type f -exec chmod 660 {} \; &&  chmod u+x bin/magento
	chown root:www-data /var/www/html -Rf
	echo -e "${COLOR}Ahora puedes accesar desde $MAGENTO_BASE_URL $MAGENTO_BACKEND_FRONTNAME${NC}"
fi
