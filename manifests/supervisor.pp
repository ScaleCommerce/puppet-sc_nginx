class sc_nginx::supervisor(
){

  include sc_supervisor
  include nginx

  file { ['/etc/init/nginx.conf', '/etc/init.d/nginx']:
    ensure => absent,
    require => Package[$nginx::package_name],
  }

  supervisord::program { 'nginx':
    command     => "/usr/sbin/nginx -g 'daemon off; master_process on;'",
    autostart   => true,
    autorestart => true,
    require     => Package[$nginx::package_name],
  }~>
  # reload nginx config only if startet for the first time
  # because of order conflict between supervisor and nginx modules
  exec {'nginx_reload':
    command     => "/usr/sbin/nginx -t && /usr/sbin/nginx -s reload",
    refreshonly => true,
    require     => Service['nginx'],
  }

  # override default service provider
  Service <| title == "nginx"|> {
    provider => supervisor,
    restart  => $nginx::service_restart,
  }
}
