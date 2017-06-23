class sc_nginx::supervisor(
  $supervisor_exec_path   = '/usr/local/bin',
){

  include sc_supervisor

  file { '/etc/init.d/nginx':
    ensure => link,
    target => "${sc_supervisor::init_path}/supervisor-init-wrapper",
  }

  file { "${supervisord::config_include}/nginx.conf":
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template("${module_name}/nginx.supervisor.conf.erb"),
    notify  => Class[supervisord::reload],
  }

  exec {'supervisorctl_nginx_update':
    command     => "${supervisor_exec_path}/supervisorctl update",
    refreshonly => true,
  }
}