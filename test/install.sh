#!/bin/bash
export PATH=/opt/puppetlabs/bin:$PATH
sed -i -e "s/nodaemon=true/nodaemon=false/" /etc/supervisord.conf
/usr/local/bin/supervisord -c /etc/supervisord.conf
echo "Puppet Version: $(puppet -V)"
puppet module install ajcrowe-supervisord
puppet module install yo61-logrotate
git clone https://github.com/ScaleCommerce/puppet-supervisor_provider.git $(puppet config print modulepath |cut -d: -f1)/supervisor_provider
curl -s https://omnitruck.chef.io/install.sh | bash -s -- -P inspec
ln -sf /builds/sc-puppet/puppet-sc_nginx/test/hiera.yaml $(puppet config print confdir |cut -d: -f1)/
ln -sf /builds/sc-puppet/puppet-sc_nginx/ $(puppet config print modulepath |cut -d: -f1)/sc_nginx
curl -s https://gitlab.scale.sc/scalecommerce/postinstall/raw/master/puppet.conf > $(puppet config print confdir |cut -d: -f1)/puppet.conf
ln -sf /builds/sc-puppet/puppet-sc_nginx/test/document_roots /var/www
puppet config set certname puppet-test.scalecommerce

#fix for scalecommerce/base:0.6
if ! dpkg-query -W apt-transport-https ; then
    apt-get update
    apt-get -y install --no-install-recommends apt-transport-https
fi
