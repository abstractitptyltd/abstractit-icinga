
class icinga::gui {

  include icinga::params
  $admin_users = $icinga::params::admin_users
  $admin_group = $icinga::params::admin_group
  $ro_users = $icinga::params::ro_users
  $ro_group = $icinga::params::ro_group
  $web_ip = $icinga::params::web_ip
  $web_port = $icinga::params::web_port
  $ssl = $icinga::params::ssl
  $webhostname = $icinga::params::webhostname

  #  include webserver::apache::ssl
  #  include webserver::php

  file { "icingacgicfg":
    name  => "/etc/icinga/cgi.cfg",
    owner  => icinga,
    group  => icinga,
    mode  => 644,
    content  => template("icinga/cgi.cfg.erb"),
  }

  file { "icingawebconf":
    name    => "${apache_mods_dir}/icinga.conf",
    owner   => root,
    group   => root,
    mode    => 644,
    content  => template("icinga/icinga_web.conf.erb"),
    notify  => Service[apache],
  }

  if ($ssl == true) {
    file { "ssl_key_$webhostname":
      name  => "$apache_ssl_dir/$webhostname.key",
      owner   => root,
      group   => root,
      mode  => 644,
      source  => "$ssl_cert_source/$webhostname.key",
      #      require  => Class["webserver::apache::ssl"],
      notify  => Service[apache],
    }
    file { "ssl_cert_$icinga_webhostname":
      name  => "$apache_ssl_dir/$webhostname.crt",
      owner   => root,
      group   => root,
      mode  => 644,
      source  => "$ssl_cert_source/$webhostname.crt",
      #      require  => Class["webserver::apache::ssl"],
      notify  => Service[apache],
    }
  }

  file { "/var/log/icinga/gui":
    ensure  => directory,
    owner  => icinga,
    group  => icingacmd,
    mode  => 2775,
  }

}

