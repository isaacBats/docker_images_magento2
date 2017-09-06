# cli-magento2
alias mag='php bin/magento'
alias mag-flush='php bin/magento cache:flush; php bin/magento cache:clean'
alias mag-compile='php bin/magento setup:di:compile'
alias mag-upgrade='php bin/magento setup:upgrade'

# helper pestle cli for magento2
if [ -f /var/www/html/pestle.phar ] || [ -f /usr/local/bin/pestle]; then
  alias pt='php pestle.phar'
fi

# github
alias glp='git log --oneline --graph --all'