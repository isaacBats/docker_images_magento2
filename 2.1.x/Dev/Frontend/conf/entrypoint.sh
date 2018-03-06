#!/usr/bin/env bash

run_unison () {
    local status=1

    while [ $status != 0 ]; do
        su - magento2 -c 'unison magento2'
        status=$?
    done
}

if [ -n $USE_SHARED_WEBROOT ]
then
    if [ $USE_SHARED_WEBROOT == "0" ]
    then

        # if using custom sources
        if [ "$(ls -A /home/magento2/magento2)" ] && [ ! "$(ls -A /var/www/html)" ]
        then
            echo "[IN PROGRESS] Sync Started." > /var/www/html/status.html
            sed -i 's/^\(\s*DirectoryIndex\s*\).*$/\1status.html/' /home/magento2/magento2/.htaccess
            cp /home/magento2/magento2/.htacces /var/www/html/
            chown magento2:magento2 /var/www/html/.htaccess
            service apache2 start

            while [ -f /home/magento2/magento2/sync-wait ]
            do
                echo .
                sleep 2
            done

            chown -R magento2:magento2 /var/www/html

            if [ -n $CREATE_SYMLINK_EE ]
            then
                if [ $CREATE_SYMLINK_EE == "1" ]
                then
                    mkdir -p $HOST_CE_PATH
                    ln -s /var/www/html/$EE_DIRNAME $HOST_CE_PATH/$EE_DIRNAME
                fi
            fi

            echo "[IN PROGRESS] Unison sync started" > /var/www/html/status.html

            run_unison

            chmod +x /var/www/html/bin/magento

            echo "[DONE] Sync Finished" > /var/www/html/status.html
            sed -i 's/^\(\s*DirectoryIndex\s*\).*$/\1index.php/' /home/magento2/magento2/.htaccess
            sed -i 's/^\(\s*DirectoryIndex\s*\).*$/\1index.php/' /var/www/html/.htaccess
            rm -rf /var/www/html/status.html
            rm -rf /home/magento2/magento2/status.html
            /usr/local/bin/check-unison.sh &
        else
            (run_unison; /usr/local/bin/check-unison.sh) &
        fi
    fi
fi

if [ $USE_UNISON_SYNC == "1" ]
then
    sudo -u magento2 sh -c '/usr/local/bin/unison -socket 5000 2>&1 >/dev/null' &
fi

supervisord -n -c /etc/supervisord.conf
