# Class icinga::gui
#
# Configures the icinga gui

class icinga::gui (
  $web_ip              = $::icinga::web_ip,
  $web_port            = $::icinga::web_port,
  $icinga_user         = $::icinga::icinga_user,
  $icinga_group         = $::icinga::icinga_group,
  $icinga_cmd_grp       = $::icinga::icinga_cmd_grp,
  $ssl                  = $::icinga::ssl,
  $ssl_cacrt            = $::icinga::ssl_cacrt,
  $ssl_cypher_list      = $::icinga::ssl_cypher_list,
  $ssl_cert_source      = $::icinga::ssl_cert_source,
  $webhostname          = $::icinga::webhostname,
  $perfdata             = $::icinga::perfdata,
  $perfdatatype         = $::icinga::perfdatatype,
  $admin_users          = $::icinga::admin_users,
  $admin_group          = $::icinga::admin_group,
  $ro_users             = $::icinga::ro_users,
  $ro_group             = $::icinga::ro_group,
  $manage_ssl           = $::icinga::manage_ssl,
  $gui_type             = $::icinga::gui_type,
  $nagios_plugins       = $::icinga::nagios_plugins,
  $ido_db_server        = $::icinga::ido_db_server,
  $ido_db_user          = $::icinga::ido_db_user,
  $ido_db_pass          = $::icinga::ido_db_pass,
  $ido_db_host          = $::icinga::ido_db_host,
  $ido_db_port          = $::icinga::ido_db_port,
  $ido_db_name          = $::icinga::ido_db_name,
  $web_auth_type        = $::icinga::web_auth_type,
  $web_auth_name        = $::icinga::web_auth_name,
  $web_auth_user_file   = $::icinga::web_auth_user_file,
  $web_auth_group_file  = $::icinga::web_auth_group_file,
  $web_auth_users       = $::icinga::web_auth_users,
  $web_db_server        = $::icinga::web_db_server,
  $web_db_user          = $::icinga::web_db_user,
  $web_db_pass          = $::icinga::web_db_pass,
  $web_db_host          = $::icinga::web_db_host,
  $web_db_port          = $::icinga::web_db_port,
  $web_db_name          = $::icinga::web_db_name,
  $ldap_security        = $::icinga::ldap_security,
  $ldap_server          = $::icinga::ldap_server,
  $ldap_firstname       = $::icinga::ldap_firstname,
  $ldap_lastname        = $::icinga::ldap_lastname,
  $ldap_email           = $::icinga::ldap_email,
  $ldap_basedn          = $::icinga::ldap_basedn,
  $ldap_groupdn         = $::icinga::ldap_groupdn,
  $ldap_binddn          = $::icinga::ldap_binddn,
  $ldap_bindpw          = $::icinga::ldap_bindpw,
  $ldap_userattr        = $::icinga::ldap_userattr,
  $ldap_groupattr       = $::icinga::ldap_groupattr,
  $ldap_filter_extra    = $::icinga::ldap_filter_extra,
  $ldap_auth_group      = $::icinga::ldap_auth_group,
  $cgi_url              = $::icinga::cgi_url,
  $cgi_path             = $::icinga::cgi_path,
  $html_path            = $::icinga::html_path,
  $css_path             = $::icinga::css_path,
  $pnp4nagios_html_path = $::icinga::pnp4nagios_html_path,
) {
  class { '::apache':
    default_vhost => false,
    mpm_module    => false,
  }

  class { '::apache::mod::prefork': }
  class { '::apache::mod::php': }
  class { '::apache::mod::rewrite': }
  class { '::apache::mod::cgi': }

  if $::operatingsystem == 'Fedora' and $::operatingsystemrelease >= 18 {
    $apache_allow_stanza = "    Require all granted\n"
  } else {
    $apache_allow_stanza = "    Order allow,deny\n    Allow from all\n"
  }
  $auth_conf       = template('icinga/etc/apache/conf.d/icinga_auth_conf.erb')
  $classic_conf    = template('icinga/etc/apache/conf.d/gui_classic_conf.erb')
  $web_conf        = template('icinga/etc/apache/conf.d/gui_web_conf.erb')
  $pnp4nagios_conf = template('icinga/etc/apache/conf.d/pnp4nagios_apache.erb')
  
  file {[$web_auth_user_file, $web_auth_group_file]:
    ensure => present,
    owner  => $apache::user,
    group  => $apache::group,
  }
  if $web_auth_users {
    Class['::apache'] -> Icinga::Gui::Basic_user <| |>
    create_resources(icinga::gui::basic_user, $web_auth_users)
  }
    
  if $gui_type =~ /^(classic|both)$/ {
    file { '/etc/icinga/cgi.cfg':
      owner   => $icinga_user,
      group   => $icinga_group,
      mode    => '0644',
      content => template('icinga/etc/icinga/cgi.cfg.erb'),
      require => Class['icinga::install'],
    }

    file { '/var/log/icinga/gui':
      ensure => directory,
      owner  => $icinga_user,
      group  => $icinga_cmd_grp,
      mode   => '2775',
    }
  }

  # # need to setup an exec to clean the web cache if these files change
  # # needs to run /usr/bin/icinga-web-clearcache
  if $gui_type =~ /^(web|both)$/ {
    file { '/etc/icinga-web/conf.d/databases.xml':
      owner   => root,
      group   => root,
      mode    => '0644',
      content => template('icinga/etc/icinga-web/conf.d/databases.xml.erb'),
      require => Class['icinga::install'],
    }

    file { '/etc/icinga-web/conf.d/auth.xml':
      owner   => root,
      group   => root,
      mode    => '0644',
      content => template('icinga/etc/icinga-web/conf.d/auth.xml.erb'),
      require => Class['icinga::install'],
    }

    # this still needs work
    # file { "/etc/icinga-web/conf.d/access.xml":
    #  owner   => root,
    #  group   => root,
    #  mode    => 644,
    #  content => template('icinga//etc/icinga-web/conf.d/access.xml.erb'),
    #}

    file { '/var/cache/icinga-web':
      ensure  => directory,
      owner   => $::apache::user,
      group   => $::apache::group,
      mode    => '0775',
      require => Class['icinga::install'],
    }

    file { '/var/log/icinga/web':
      ensure  => directory,
      owner   => $icinga_user,
      group   => $icinga_cmd_grp,
      mode    => '2775',
      require => Class['icinga::install'],
    }
  }
  if $manage_ssl {
    $ssl_cert   = "${apache::ssl_path}/${webhostname}.crt"
    $ssl_key    = "${apache::ssl_path}/${webhostname}.key"
    $ssl_ca     = $ssl_cacrt
    $ssl_cipher = $ssl_cypher_list
  } else {
    $ssl_cert   = undef
    $ssl_key    = undef
    $ssl_ca     = undef
    $ssl_cipher = undef
  }
  $docroot  = $gui_type ? {
    default => $html_path,
    'web'   => '/usr/share/icinga-web/pub'
  }
  apache::vhost { $webhostname:
    ip              => $web_ip,
    port            => $web_port,
    docroot         => $docroot,
    docroot_owner   => root,
    docroot_group   => root,
    custom_fragment => template('icinga/etc/apache/conf.d/apache_extra.conf.erb'),
    ssl             => $ssl,
    ssl_cert        => $ssl_cert,
    ssl_key         => $ssl_key,
    ssl_ca          => $ssl_ca,
    ssl_cipher      => $ssl_cipher,
    ssl_options     => '+FakeBasicAuth +ExportCertData +StdEnvVars +StrictRequire',
    access_log_file => 'icinga-web-access_log',
    error_log_file  => 'icinga-web-error_log',
  }

  if $ssl and $manage_ssl {
    if $ssl_cert_source {
      include apache::mod::ssl

      if !defined(File["ssl_key_${webhostname}"]) {
        file { "ssl_key_${webhostname}":
          name   => "${apache::ssl_path}/${webhostname}.key",
          owner  => root,
          group  => root,
          mode   => '0644',
          source => "${ssl_cert_source}/${webhostname}.key",
          notify => Service[httpd],
        }
      }

      if !defined(File["ssl_crt_${webhostname}"]) {
        file { "ssl_crt_${webhostname}":
          name   => "${apache::ssl_path}/${webhostname}.crt",
          owner  => root,
          group  => root,
          mode   => '0644',
          source => "${ssl_cert_source}/${webhostname}.crt",
          notify => Service[httpd],
        }
      }
    } else {
      warning('manage_ssl set but no ssl_cert_source not set. ssl not enabled')
    }
  }
}

