# cli-magento2
alias mag='php bin/magento'
alias mag-flush='php bin/magento cache:flush; php bin/magento cache:clean'
alias mag-compile='php bin/magento setup:di:compile'
alias mag-upgrade='php bin/magento setup:upgrade'

# helper pestle cli for magento2
if [ -f /var/www/html/pestle.phar ]; then
  alias pt='php pestle.phar'
elif [ -f /usr/local/bin/pestle ]; then
  alias pt='pestle'
fi

# github
alias gc='git checkout'
alias gst='git status'
alias gcb='git checkout -b'
alias gcmma='git commit -am'
alias gcmm='git commit -m'
alias gst='git status'
alias gbc='git branch'
alias gpuo='git pull origin'
alias gpuso='git push origin'
alias glp='git log --all --oneline --graph'
