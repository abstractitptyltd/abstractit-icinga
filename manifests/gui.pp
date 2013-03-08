
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
    apache::sslcert{ $webhostname:
    }
  }

  file { "/var/log/icinga/gui":
    ensure  => directory,
    owner  => icinga,
    group  => icingacmd,
    mode  => 2775,
  }

}

