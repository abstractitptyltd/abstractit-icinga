
class icinga::gui {

  include apache
  include apache::mod::php
  include icinga::params
  $admin_users = $icinga::params::admin_users
  $admin_group = $icinga::params::admin_group
  $ro_users = $icinga::params::ro_users
  $ro_group = $icinga::params::ro_group

  file { "icingacgicfg":
    name  => "/etc/icinga/cgi.cfg",
    owner  => icinga,
    group  => icinga,
    mode  => 644,
    content  => template("icinga/cgi.cfg.erb"),
  }

  apache::vhost { $icinga::params::webhostname:
    port => $icinga::params::web_port,
    docroot => '/usr/share/icinga/',
    docroot_owner => root,
    docroot_group => root,
    template => "icinga/icinga_web.conf.erb",
  }

  if ($icinga::params::ssl == true) {
    include apache::ssl
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

