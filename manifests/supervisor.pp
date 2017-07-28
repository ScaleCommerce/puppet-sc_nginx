class sc_nginx::supervisor(
){

  include sc_supervisor
  include nginx

  file { ['/etc/init/nginx.conf', '/etc/init.d/nginx']:
    ensure  => absent,
    require => Package[$nginx::package_name],
    before  => Service['nginx'],
  }

  file { "${supervisord::config_include}/nginx.conf":
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template("${module_name}/nginx.supervisor.conf.erb"),
    notify  => Class[supervisord::reload],
    before  => Service['nginx'],
    require => Package[$nginx::package_name],
  }

  #override puppet service provider to supervisor
  Service <| title == "nginx" |> {
    provider => supervisor,
  }
}
