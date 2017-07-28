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

  # this block is needed to fix missing hiera_hash support of puppet-nginx module
  if defined('nginx::resource::geo_mapping') {
    ensure_resources('nginx::resource::geo_mapping', hiera_hash('nginx::geo_mappings', {}))
  }
  if defined('nginx::resource::string_mapping') {
    ensure_resources('nginx::resource::string_mapping', hiera_hash('nginx::string_mappings', {}))
  }
  if defined('nginx::resource::location') {
    ensure_resources('nginx::resource::location', hiera_hash('nginx::nginx_locations', {}), hiera_hash('nginx::nginx_locations_defaults', {}))
  }
  if defined('nginx::resource::upstream') {
    ensure_resources('nginx::resource::upstream', hiera_hash('nginx::nginx_upstreams', {}))
  }
  if defined('nginx::resource::server') {
    ensure_resources('nginx::resource::server', hiera_hash('nginx::nginx_servers', {}), hiera_hash('nginx::nginx_servers_defaults', {}))
  }

  # this is only needed as a fix for jfryman-nginx module [deprecated]
  if defined('nginx::resource::vhost') {
    Class['apt::update'] -> Package[$nginx::package_name] -> Nginx::Resource::Vhost <| |>
    ensure_resources('nginx::resource::vhost', hiera_hash('nginx::nginx_vhosts', {}), hiera_hash('nginx::nginx_vhosts_defaults', {}))
  }
}
