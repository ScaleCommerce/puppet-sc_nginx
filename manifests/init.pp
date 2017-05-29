# == Class: sc_nginx
#
# ScaleCommerce Wrapper Module for puppet-nginx.
# Manages Supervisord.
#
# === Variables
#
# [*supervisor_init_script*]
#  full path to supervisor init wrapper script
#
# [*supervisor_conf_script*
#  full path to supervisor conf script
#
# [*supervisor_exec_path*]
#  path to supervisor executable
#
# === Authors
#
# Andreas Ziethen <az@scale.sc>
#
# === Copyright
#
# Copyright 2017 ScaleCommerce GmbH.
#

class sc_nginx (
  $supervisor_init_script = '/etc/supervisor.init/supervisor-init-wrapper',
  $supervisor_conf_script = '/etc/supervisor.d/nginx.conf',
  $supervisor_exec_path   = '/usr/local/bin',
) {

  include nginx

  # supervisor
  file { '/etc/init/nginx.conf':
    ensure => absent,
  }->
  file { '/etc/init.d/nginx':
    ensure => link,
    target => $supervisor_init_script,
  }

  file { $supervisor_conf_script:
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template("${module_name}/nginx.supervisor.conf.erb"),
    notify  => Exec['supervisorctl_nginx_update'],
  }

  exec {'supervisorctl_nginx_update':
    command     => "${supervisor_exec_path}/supervisorctl update",
    refreshonly => true,
  }
}