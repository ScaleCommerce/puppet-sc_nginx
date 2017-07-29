#!/bin/bash
sed -i -e "s/nodaemon=true/nodaemon=false/" /etc/supervisord.conf
/usr/local/bin/supervisord -c /etc/supervisord.conf
apt-get purge -y puppet*
wget https://apt.puppetlabs.com/puppetlabs-release-pc1-xenial.deb
dpkg -i puppetlabs-release-pc1-xenial.deb
apt-get update
apt-get -y install --no-install-recommends apt-transport-https puppet-agent
export PATH=/opt/puppetlabs/bin:$PATH
puppet -V
puppet module install ajcrowe-supervisord
puppet module install yo61-logrotate
git clone https://github.com/ScaleCommerce/puppet-sc_supervisor.git /etc/puppetlabs/code/environments/production/modules/sc_supervisor
git clone https://github.com/ScaleCommerce/puppet-supervisor_provider.git /etc/puppetlabs/code/environments/production/modules/supervisor_provider
curl -s https://omnitruck.chef.io/install.sh | bash -s -- -P inspec
ln -sf /builds/sc-puppet/puppet-sc_nginx/test/hiera5.yaml /etc/puppetlabs/puppet/
ln -sf /builds/sc-puppet/puppet-sc_nginx/ /etc/puppetlabs/code/environments/production/modules/sc_nginx
curl -s https://gitlab.scale.sc/scalecommerce/postinstall/raw/master/puppet.conf > /etc/puppetlabs/puppet/puppet.conf
ln -sf /builds/sc-puppet/puppet-sc_nginx/test/document_roots /var/www
puppet config set certname puppet-test.scalecommerce
