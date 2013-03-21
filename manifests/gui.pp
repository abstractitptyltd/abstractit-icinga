
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
    configure_firewall => $icinga::params::configure_firewall,
  }

  if ($icinga::params::ssl == true) {
    include apache::ssl
    file { "ssl_key_${icinga::params::webhostname}":
      name  => "${apache::params::ssl_path}/${icinga::params::webhostname}.key",
      owner   => root,
      group   => root,
      mode  => 644,
      source  => "${icinga::params::ssl_cert_source}/${icinga::params::webhostname}.key",
      notify  => Service[apache],
    }
    file { "ssl_crt_${icinga::params::webhostname}":
      name  => "${apache::params::ssl_path}/${icinga::params::webhostname}.crt",
      owner   => root,
      group   => root,
      mode  => 644,
      source  => "${icinga::params::ssl_cert_source}/${icinga::params::webhostname}.crt",
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

