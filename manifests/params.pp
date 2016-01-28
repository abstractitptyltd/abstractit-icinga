# Class icinga::params
#
# base params for icinga

class icinga::params {
  $web_ip               = $::ipaddress
  $web_port             = 443
  $ssl                  = true
  $ssl_cacrt            = undef
  $ssl_cypher_list      = 'ALL:!ADH:RC4+RSA:+HIGH:!MEDIUM:!LOW:!SSLv2:+SSLv3:+TLSv1:!EXP:!eNULL'
  $manage_users         = true
  $manage_repo          = true
  $manage_ssl           = false
  $webhostname          = $::fqdn
  $configure_firewall   = true
  $gui_type             = 'classic'
  $notifications        = true
  $embedded_perl        = 0
  $perfdata             = false
  $perfdatatype         = 'pnp4nagios'
  $admin_group          = undef
  $admin_users          = undef
  $ro_users             = undef
  $ro_group             = undef
  $check_timeout        = 180
  $debug                = 0
  $admin_email          = 'icinga@localhost'
  $admin_pager          = 'pageicinga@localhost'
  $stalking             = 0
  $flap_detection       = 1
  $enable_ido           = true
  $ido_db_server        = 'mysql'
  $ido_db_host          = 'localhost'
  $ido_db_port          = 3306
  $ido_db_name          = 'icinga'
  $ido_db_user          = 'icinga'
  $ido_db_pass          = 'icinga'
  $web_db_server        = 'mysql'
  $web_db_host          = 'localhost'
  $web_db_port          = 3306
  $web_db_name          = 'icinga_web'
  $web_db_user          = 'icinga_web'
  $web_db_pass          = 'icinga_web'
  $web_auth_type        = 'internal'
  $web_auth_name        = 'user_defined_1'
  $web_auth_users       = {}
  $ldap_security        = 'tls'
  $ldap_server          = "ldap.${::domain}"
  $ldap_firstname       = 'givenName'
  $ldap_lastname        = 'sn'
  $ldap_email           = 'mail'
  $ldap_basedn          = undef
  $ldap_groupdn         = undef
  $ldap_binddn          = undef
  $ldap_bindpw          = undef
  $ldap_userattr        = 'uid'
  $ldap_groupattr       = 'memberOf'
  $ldap_filter_extra    = undef
  $ldap_auth_group      = undef
  $nagios_extra_plugins = undef
  $icinga_cmd_grp       = 'icingacmd'
  $db_password          = undef
  $email_user           = undef
  $email_password       = undef
  $ssl_cert_source      = undef
  $clickatell_api_id    = undef
  $clickatell_username  = undef
  $clickatell_password  = undef
  $is_pbx               = false
  $pbx_mngr_pw          = undef
  case $::osfamily {
    'RedHat': {
      case $::architecture {
        'x86_64': {
          $nagios_plugins  = '/usr/lib64/nagios/plugins'
          $cgi_path        = '/usr/lib64/icinga/cgi'
        }
        default: {
          $nagios_plugins  = '/usr/lib/nagios/plugins'
          $cgi_path        = '/usr/lib/icinga/cgi'
        }
      }
      $html_path            = '/usr/share/icinga'
      $css_path             = undef
      $pnp4nagios_html_path = '/usr/share/nagios/html/pnp4nagios'
      $cgi_url              = '/icinga/cgi-bin'
      $icinga_user          = 'icinga'
      $icinga_group         = 'icinga'
      $web_auth_user_file   = '/etc/httpd/htpasswd.users'
      $web_auth_group_file  = '/etc/httpd/htpasswd.groups'
    }
    'Debian': {
      $nagios_plugins       = '/usr/lib/nagios/plugins'
      $cgi_path             = '/usr/lib/cgi-bin/icinga'
      $html_path            = '/usr/share/icinga/htdocs'
      $css_path             = '/etc/icinga/stylesheets'
      $pnp4nagios_html_path = '/usr/share/pnp4nagios/html'
      $cgi_url              = '/cgi-bin/icinga'
      $web_auth_user_file   = '/etc/apache2/htpasswd.users'
      $web_auth_group_file  = '/etc/apache2/htpasswd.groups'
      case $::lsbdistcodename {
        'trusty': {
          $icinga_user          = 'nagios'
          $icinga_group         = 'nagios'
        }
        default: {
          $icinga_user          = 'icinga'
          $icinga_group         = 'icinga'
        }
      }
    }
    default: {
      fail("Only Debian/Red Hat based systems supported, not ${::osfamily}")
    }
  }
}

