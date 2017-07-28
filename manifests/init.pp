# == Class: sc_nginx
#
# ScaleCommerce Wrapper Module for puppet-nginx.
# Manages Supervisord.
#
# === Variables
#
# [*use_supervisor*]
#   can be true or false, default is true.
#   determines if start script should be used with supervisor
#
# === Authors
#
# Andreas Ziethen <az@scale.sc>
# Thomas Lohner <tl@scale.sc>
#
# === Copyright
#
# Copyright 2017 ScaleCommerce GmbH.
#

class sc_nginx (
  $use_supervisor = true,
) {

  if $use_supervisor {
    class {'::sc_nginx::supervisor':}
  }

  include nginx

  # this is only needed as a fix for jfryman-nginx module
  if defined('nginx::resource::vhost') {
    Class['apt::update'] -> Package[$nginx::package_name] -> Nginx::Resource::Vhost <| |>
  }
}
