# Class icinga::gui
#
# Configures the icinga gui

class icinga::gui {

  include ::apache
  include ::apache::mod::php
  include icinga::params
  $icinga_user = $icinga::params::icinga_user
  $icinga_group = $icinga::params::icinga_group
  $icinga_cmd_grp = $icinga::params::icinga_cmd_grp
  $admin_users = $icinga::params::admin_users
  $admin_group = $icinga::params::admin_group
  $ro_users = $icinga::params::ro_users
  $ro_group = $icinga::params::ro_group
  $ssl = $icinga::params::ssl

  # check if we are running pgsql and fix port if it is set to default mysql port
  if $icinga::params::web_db_server == 'pgsql' and $icinga::params::web_db_port == 3306 {
    $web_db_port = 5432
  } else {
    $web_db_port = $icinga::params::web_db_port
  }

  # check if we are running pgsql and fix port if it is set to default mysql port
  if $icinga::params::ido_db_server == 'pgsql' and $icinga::params::ido_db_port == 3306 {
    $ido_db_port = 5432
  } else {
    $ido_db_port = $icinga::params::ido_db_port
  }

  if $::operatingsystem == 'Fedora' and $::operatingsystemrelease >= 18 {
    $apache_allow_stanza = "    Require all granted\n"
  } else {
    $apache_allow_stanza = "    Order allow,deny\n    Allow from all\n"
  }
  $auth_conf = template($icinga::params::auth_template)
  $classic_conf = template('icinga/gui_classic_conf.erb')
  $web_conf = template('icinga/gui_web_conf.erb')
  $pnp4nagios_conf = template('icinga/pnp4nagios_apache.erb')
  $ldap_conf = template('icinga/apache_ldap.conf.erb')


  if $icinga::params::gui_type =~ /^(classic|both)$/ {
    file { '/etc/icinga/cgi.cfg':
      owner   => $icinga_user,
      group   => $icinga_group,
      mode    => '0644',
      content => template('icinga/cgi.cfg.erb'),
    }
    file { '/var/log/icinga/gui':
      ensure => directory,
      owner  => $icinga_user,
      group  => $icinga_cmd_grp,
      mode   => '2775',
    }
  }

  ## need to setup an exec to clean the web cache if these files change
  ## needs to run /usr/bin/icinga-web-clearcache
  if $icinga::params::gui_type =~ /^(web|both)$/ {
    file { '/etc/icinga-web/conf.d/databases.xml':
      owner   => root,
      group   => root,
      mode    => '0644',
      content => template('icinga/databases.xml.erb'),
    }
    file { '/etc/icinga-web/conf.d/auth.xml':
      owner   => root,
      group   => root,
      mode    => '0644',
      content => template('icinga/auth.xml.erb'),
    }

    # this still needs work
    #file { "/etc/icinga-web/conf.d/access.xml":
    #  owner   => root,
    #  group   => root,
    #  mode    => 644,
    #  content => template('icinga/access.xml.erb'),
    #}

    file { '/var/cache/icinga-web':
      ensure => directory,
      owner  => $::apache::params::user,
      group  => $::apache::params::group,
      mode   => '0775',
    }
    file { '/var/log/icinga/web':
      ensure => directory,
      owner  => $icinga_user,
      group  => $icinga_cmd_grp,
      mode   => '2775',
    }
  }

  apache::vhost { $icinga::params::webhostname:
    ip                  => $icinga::params::web_ip,
    port                => $icinga::params::web_port,
    docroot             => $icinga::params::gui_type ? {
      default           => '/usr/share/icinga/',
      'web'             => '/usr/share/icinga-web/pub' },
    docroot_owner       => root,
    docroot_group       => root,
    custom_fragment     => template('icinga/apache_extra.conf.erb'),
    #configure_firewall => $icinga::params::configure_firewall,
    ssl                 => $icinga::params::ssl,
    ssl_cert            => $icinga::params::manage_ssl ? {
      default           => undef,
      true              => "${apache::params::ssl_path}/${icinga::params::webhostname}.crt", },
    ssl_key             => $icinga::params::manage_ssl ? {
      default           => undef,
      true              => "${apache::params::ssl_path}/${icinga::params::webhostname}.key", },
    ssl_ca              => $icinga::params::manage_ssl ? {
      default           => undef,
      true              => $icinga::params::ssl_cacrt, },
    ssl_cipher          => $icinga::params::manage_ssl ? {
      default           => undef,
      true              => $icinga::params::ssl_cypher_list, },
    ssl_options         => '+FakeBasicAuth +ExportCertData +StdEnvVars +StrictRequire',
    access_log_file     => 'icinga-web-access_log',
    error_log_file      => 'icinga-web-error_log',
  }

  if ( $ssl == true ) {
    if ( $icinga::params::manage_ssl == true and $icinga::params::ssl_cert_source != '' ) {
      include apache::mod::ssl
      if ! defined(File["ssl_key_${icinga::params::webhostname}"]) {
        file { "ssl_key_${icinga::params::webhostname}":
          name   => "${apache::params::ssl_path}/${icinga::params::webhostname}.key",
          owner  => root,
          group  => root,
          mode   => '0644',
          source => "${icinga::params::ssl_cert_source}/${icinga::params::webhostname}.key",
          notify => Service[httpd],
        }
      }
      if ! defined(File["ssl_crt_${icinga::params::webhostname}"]) {
        file { "ssl_crt_${icinga::params::webhostname}":
          name   => "${apache::params::ssl_path}/${icinga::params::webhostname}.crt",
          owner  => root,
          group  => root,
          mode   => '0644',
          source => "${icinga::params::ssl_cert_source}/${icinga::params::webhostname}.crt",
          notify => Service[httpd],
        }
      }
    } else {
      warning('ssl_cert_source not set. ssl not enabled')
    }
  }

}

