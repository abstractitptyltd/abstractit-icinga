
class icinga::params (
  $web_ip = $ipaddress,
  $web_port = 443,
  $ssl = true,
  $ssl_cacrt = undef,
  $ssl_cypher_list = 'ALL:!ADH:RC4+RSA:+HIGH:!MEDIUM:!LOW:!SSLv2:+SSLv3:+TLSv1:!EXP:!eNULL',
  $manage_ssl = true,
  $webhostname = $fqdn,
  $configure_firewall = true,
  $gui_type = "classic",
  $auth_template = "icinga/icinga_auth_conf.erb",
  $notifications = 1,
  $embedded_perl = 0,
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
  $web_auth_name = "user_defined_1",
  $ldap_ssl = false,
  $ldap_tls = true,
  $ldap_server = "ldap.${domain}",
  $ldap_firstname = 'givenName',
  $ldap_lastname = 'sn',
  $ldap_email = 'mail',
  $ldap_basedn = undef,
  $ldap_binddn = undef,
  $ldap_bindpw = undef,
  $ldap_userattr = uid,
  $ldap_filter_extra = undef,
) {
  $nagios_plugins = $architecture ? { 'x86_64' => '/usr/lib64/nagios/plugins', default => '/usr/lib/nagios/plugins'}
  $nagios_extra_plugins = hiera('monitoring::params::nagios_extra_plugins', undef)
  $icinga_cmd_grp = 'icingacmd'
  $db_password = hiera('monitoring::db_password')
  $email_user = hiera('monitoring::email_user')
  $email_password = hiera('monitoring::email_password')
  $ssl_cert_source = hiera('ssl_cert_source')
  # validate some params
  validate_re($gui_type, '^(classic|web|both|none)$',
  "${gui_type} is not supported for gui_type.
  Allowed values are 'classic', 'web', 'both' and 'none'.")
  # validate auth params
  validate_re($web_auth_type, '^(internal|httpbasic|ldap|none)$',
  "${web_auth_type} is not supported for web_auth_type.
  Allowed values are 'internal', 'httpbasic', 'ldap' and 'none'.")
}

