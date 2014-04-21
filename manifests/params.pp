# Class icinga::params
#
# base params for icinga

class icinga::params (
  $web_ip = $::ipaddress,
  $web_port = 443,
  $icinga_user = 'icinga',
  $icinga_group = 'icinga',
  $icinga_cgi_path = '',
  $icinga_html_path = '',
  $icinga_css_path = '',
  $ssl = true,
  $ssl_cacrt = undef,
  $ssl_cypher_list = 'ALL:!ADH:RC4+RSA:+HIGH:!MEDIUM:!LOW:!SSLv2:+SSLv3:+TLSv1:!EXP:!eNULL',
  $manage_ssl = false,
  $webhostname = $::fqdn,
  $configure_firewall = true,
  $gui_type = 'classic',
  $auth_template = 'icinga/icinga_auth_conf.erb',
  $notifications = 1,
  $embedded_perl = 0,
  $perfdata = false,
  $perfdatatype = 'pnp4nagios',
  $pnp4nagios_html_path = '',
  $admin_group = undef,
  $admin_users = undef,
  $ro_users = undef,
  $ro_group = undef,
  $check_timeout = 180,
  $debug = 0,
  $admin_email = 'icinga@localhost',
  $admin_pager = 'pageicinga@localhost',
  $stalking = 0,
  $flap_detection = 1,
  $ido_db_server = 'mysql',
  $ido_db_host = 'localhost',
  $ido_db_port = 3306,
  $ido_db_name = 'icinga',
  $ido_db_user = 'icinga',
  $ido_db_pass = 'icinga',
  $web_db_server = 'mysql',
  $web_db_host = 'localhost',
  $web_db_port = 3306,
  $web_db_name = 'icinga_web',
  $web_db_user = 'icinga_web',
  $web_db_pass = 'icinga_web',
  $web_auth_type = 'internal',
  $web_auth_name = 'user_defined_1',
  $ldap_security = 'tls',
  $ldap_server = "ldap.${::domain}",
  $ldap_firstname = 'givenName',
  $ldap_lastname = 'sn',
  $ldap_email = 'mail',
  $ldap_basedn = undef,
  $ldap_groupdn = undef,
  $ldap_binddn = undef,
  $ldap_bindpw = undef,
  $ldap_userattr = 'uid',
  $ldap_groupattr = 'memberOf',
  $ldap_filter_extra = undef,
  $ldap_auth_group = undef,
) {
  if $::architecture == 'x86_64' and $::osfamily == 'RedHat' {
    $nagios_plugins = '/usr/lib64/nagios/plugins'
  } else {
    $nagios_plugins = '/usr/lib/nagios/plugins'
  }
  $nagios_extra_plugins = hiera('monitoring::params::nagios_extra_plugins', $nagios_plugins)
  $icinga_cmd_grp = 'icingacmd'
  $db_password = hiera('monitoring::db_password', '')
  $email_user = hiera('monitoring::email_user', '')
  $email_password = hiera('monitoring::email_password', '')
  $ssl_cert_source = hiera('ssl_cert_source', '')
  case $::osfamily {
    'RedHat': {
      if $icinga_cgi_path == '' {
        $icinga_cgi_path_real = $::architecture ? {
          'x86_64' => '/usr/lib64/icinga/cgi',
          default  => '/usr/lib/icinga/cgi'
        }
      }
      else {
        $icinga_cgi_path_real = $icinga_cgi_path
      }

      if $icinga_html_path == '' {
        $icinga_html_path_real = '/usr/share/icinga'
      }
      else {
        $icinga_html_path_real = $icinga_html_path
      }

      $icinga_css_path_real = $icinga_css_path

      if $pnp4nagios_html_path == '' {
        $pnp4nagios_html_path_real = '/usr/share/nagios/html/pnp4nagios'
      }
      else {
        $pnp4nagios_html_path_real = $pnp4nagios_html_path
      }

      $cgi_url = '/icinga/cgi-bin'
    }
    'Debian': {
      if $icinga_cgi_path == '' {
        $icinga_cgi_path_real = '/usr/lib/cgi-bin/icinga'
      }
      else {
        $icinga_cgi_path_real = $icinga_cgi_path
      }

      if $icinga_html_path == '' {
        $icinga_html_path_real = '/usr/share/icinga/htdocs'
      }
      else {
        $icinga_html_path_real = $icinga_html_path
      }

      if $icinga_css_path == '' {
        $icinga_css_path_real = '/etc/icinga/stylesheets'
      }
      else {
        $icinga_css_path_real = $icinga_css_path
      }

      if $pnp4nagios_html_path == '' {
        $pnp4nagios_html_path_real = '/usr/share/pnp4nagios/html'
      }
      else {
        $pnp4nagios_html_path_real = $pnp4nagios_html_path
      }

      $cgi_url = '/cgi-bin/icinga'
    }
    default: {
      fail("Only Debian/Red Hat based systems supported, not ${::osfamily}")
    }
  }
  # validate some params
  validate_re($gui_type, '^(classic|web|both|none)$',
  "${gui_type} is not supported for gui_type.
  Allowed values are 'classic', 'web', 'both' and 'none'.")
  # validate auth params
  validate_re($web_auth_type, '^(internal|httpbasic|ldap|none)$',
  "${web_auth_type} is not supported for web_auth_type.
  Allowed values are 'internal', 'httpbasic', 'ldap' and 'none'.")
  validate_re($ldap_security, '^(tls|ssl|none)$',
  "${ldap_security} is not supported for ldap_security.
  Allowed values are 'tls', 'ssl' and 'none'.")
}

