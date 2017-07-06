#!/bin/bash
sed -i -e "s/nodaemon=true/nodaemon=false/" /etc/supervisord.conf
/usr/local/bin/supervisord -c /etc/supervisord.conf
apt-get update
apt-get -y install curl sudo puppet ruby1.9.1-dev make gcc nano software-properties-common rsync git dnsutils unzip whois python-software-properties python-pip psmisc
gem install --no-rdoc --no-ri librarian-puppet
curl https://omnitruck.chef.io/install.sh | sudo bash -s -- -P inspec
ln -sf test/hiera.yaml /etc/puppet/
ln -sf test/Puppetfile /etc/puppet/
ln -sf test/hiera /var/lib/hiera
ln -sf . /etc/puppet/modules/sc_nginx
cd /etc/puppet ; librarian-puppet install
curl https://gitlab.scale.sc/scalecommerce/postinstall/raw/master/puppet.conf.sample > /etc/puppet/puppet.conf
puppet config set certname puppet-test.scalecommerce