#!/bin/bash
sed -i -e "s/nodaemon=true/nodaemon=false/" /etc/supervisord.conf
/usr/local/bin/supervisord -c /etc/supervisord.conf
apt-get install apt-transport-https
puppet module install ajcrowe-supervisord
puppet module install yo61-logrotate
git clone http://github.com/ScaleCommerce/puppet-sc_supervisor.git /etc/puppet/modules/sc_supervisor
curl -s https://omnitruck.chef.io/install.sh | sudo bash -s -- -P inspec
ln -sf /builds/sc-puppet/puppet-sc_nginx/test/hiera.yaml /etc/puppet/
ln -sf /builds/sc-puppet/puppet-sc_nginx/test/Puppetfile /etc/puppet/
ln -sf /builds/sc-puppet/puppet-sc_nginx/test/hiera /var/lib/hiera
ln -sf /builds/sc-puppet/puppet-sc_nginx/ /etc/puppet/modules/sc_nginx
curl -s https://gitlab.scale.sc/scalecommerce/postinstall/raw/master/puppet.conf.sample > /etc/puppet/puppet.conf
puppet config set certname puppet-test.scalecommerce
