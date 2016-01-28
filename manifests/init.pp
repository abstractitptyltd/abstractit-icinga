# Class icinga
#
# setup icinga
# full docs in README.md

class icinga (
  $web_ip                    = $::icinga::params::web_ip,
  $web_port                  = $::icinga::params::web_port,
  $icinga_user               = $::icinga::params::icinga_user,
  $icinga_group              = $::icinga::params::icinga_group,
  $icinga_cgi_path           = $::icinga::params::icinga_cgi_path,
  $icinga_html_path          = $::icinga::params::icinga_html_path,
  $icinga_css_path           = $::icinga::params::icinga_css_path,
  $ssl                       = $::icinga::params::ssl,
  $ssl_cacrt                 = $::icinga::params::ssl_cacrt,
  $ssl_cypher_list           = $::icinga::params::ssl_cypher_list,
  $manage_ssl                = $::icinga::params::manage_ssl,
  $manage_users              = $::icinga::params::manage_users,
  $manage_repo               = $::icinga::params::manage_repo,
  $webhostname               = $::icinga::params::webhostname,
  $configure_firewall        = $::icinga::params::configure_firewall,
  $gui_type                  = $::icinga::params::gui_type,
  $notifications             = $::icinga::params::notifications,
  $embedded_perl             = $::icinga::params::embedded_perl,
  $perfdata                  = $::icinga::params::perfdata,
  $perfdatatype              = $::icinga::params::perfdatatype,
  $pnp4nagios_html_path      = $::icinga::params::pnp4nagios_html_path,
  $admin_group               = $::icinga::params::admin_group,
  $admin_users               = $::icinga::params::admin_users,
  $ro_users                  = $::icinga::params::ro_users,
  $ro_group                  = $::icinga::params::ro_group,
  $check_timeout             = $::icinga::params::check_timeout,
  $debug                     = $::icinga::params::debug,
  $admin_email               = $::icinga::params::admin_email,
  $admin_pager               = $::icinga::params::admin_pager,
  $stalking                  = $::icinga::params::stalking,
  $flap_detection            = $::icinga::params::flap_detection,
  $enable_ido                = $::icinga::params::enable_ido,
  $ido_db_server             = $::icinga::params::ido_db_server,
  $ido_db_host               = $::icinga::params::ido_db_host,
  $ido_db_port               = $::icinga::params::ido_db_port,
  $ido_db_name               = $::icinga::params::ido_db_name,
  $ido_db_user               = $::icinga::params::ido_db_user,
  $ido_db_pass               = $::icinga::params::ido_db_pass,
  $web_db_server             = $::icinga::params::web_db_server,
  $web_db_host               = $::icinga::params::web_db_host,
  $web_db_port               = $::icinga::params::web_db_port,
  $web_db_name               = $::icinga::params::web_db_name,
  $web_db_user               = $::icinga::params::web_db_user,
  $web_db_pass               = $::icinga::params::web_db_pass,
  $web_auth_type             = $::icinga::params::web_auth_type,
  $web_auth_user_file        = $::icinga::params::web_auth_user_file,
  $web_auth_group_file       = $::icinga::params::web_auth_group_file,
  $web_auth_users            = $::icinga::params::web_auth_users,
  $web_auth_name             = $::icinga::params::web_auth_name,
  $ldap_security             = $::icinga::params::ldap_security,
  $ldap_server               = $::icinga::params::ldap_server,
  $ldap_firstname            = $::icinga::params::ldap_firstname,
  $ldap_lastname             = $::icinga::params::ldap_lastname,
  $ldap_email                = $::icinga::params::ldap_email,
  $ldap_basedn               = $::icinga::params::ldap_basedn,
  $ldap_groupdn              = $::icinga::params::ldap_groupdn,
  $ldap_binddn               = $::icinga::params::ldap_binddn,
  $ldap_bindpw               = $::icinga::params::ldap_bindpw,
  $ldap_userattr             = $::icinga::params::ldap_userattr,
  $ldap_groupattr            = $::icinga::params::ldap_groupattr,
  $ldap_filter_extra         = $::icinga::params::ldap_filter_extra,
  $ldap_auth_group           = $::icinga::params::ldap_auth_group,
  $nagios_plugins            = $::icinga::params::nagios_plugins,
  $nagios_extra_plugins      = $::icinga::params::nagios_extra_plugins,
  $icinga_cmd_grp            = $::icinga::params::icinga_cmd_grp,
  $db_password               = $::icinga::params::db_password,
  $email_user                = $::icinga::params::email_user,
  $email_password            = $::icinga::params::email_password,
  $ssl_cert_source           = $::icinga::params::ssl_cert_source,
  $icinga_cgi_path           = $::icinga::params::icinga_cgi_path,
  $icinga_html_path          = $::icinga::params::icinga_html_path,
  $icinga_css_path           = $::icinga::params::icinga_css_path,
  $pnp4nagios_html_path      = $::icinga::params::pnp4nagios_html_path,
  $cgi_url                   = $::icinga::params::cgi_url,
  $cgi_path                  = $::icinga::params::cgi_path,
  $html_path                 = $::icinga::params::html_path,
  $css_path                  = $::icinga::params::css_path,
  $pnp4nagios_html_path      = $::icinga::params::pnp4nagios_html_path,
  $clickatell_api_id         = $::icinga::params::clickatell_api_id,
  $clickatell_username       = $::icinga::params::clickatell_username,
  $clickatell_password       = $::icinga::params::clickatell_password,
  $is_pbx                    = $::icinga::params::is_pbx,
  $pbx_mngr_pw               = $::icinga::params::pbx_mngr_pw
) inherits ::icinga::params {
  #could be much better
  $email_regex           = '^[\w\@\.\-]+$'
  $host_regex            = '^[\w\.-]+$'
  $gui_options           = '^(classic|web|both)$'
  $db_options            = '^(mysql|pgsql)$'
  $auth_type_options     = '^(internal|httpbasic|ldap|none)$'
  $ldap_security_options = '^(tls|ssl|none)$'

  unless is_ip_address($web_ip) {
    fail("\$web_ip (${web_ip}) Must be a valid ip address")
  }
  validate_integer($web_port)
  validate_string($icinga_user)
  validate_string($icinga_group)
  validate_string($icinga_cgi_path)
  validate_string($icinga_html_path)
  validate_string($icinga_css_path)
  validate_bool($ssl)
  if $ssl_cacrt {
    validate_absolute_path($ssl_cacrt)
  }
  validate_string($ssl_cypher_list)
  validate_bool($manage_users)
  validate_bool($manage_repo)
  validate_bool($manage_ssl)
  validate_re($webhostname, $host_regex)
  validate_bool($configure_firewall)
  validate_re($gui_type, $gui_options)
  #this should probably be a bool
  validate_bool($notifications)
  #this should probably be a bool
  validate_integer($embedded_perl)
  validate_bool($perfdata)
  validate_string($perfdatatype)
  validate_string($pnp4nagios_html_path)
  if $admin_group {
    validate_string($admin_group)
  }
  if $admin_users {
    validate_string($admin_users)
  }
  if $ro_users {
    validate_string($ro_users)
  }
  if $ro_group {
    validate_string($ro_group)
  }
  validate_integer($check_timeout)
  #this should probably be a bool
  validate_integer($debug)
  validate_re($admin_email, $email_regex)
  validate_re($admin_pager, $email_regex)
  #this should probably be a bool
  validate_integer($stalking)
  #this should probably be a bool
  validate_integer($flap_detection)
  validate_bool($enable_ido)
  validate_re($ido_db_server, $db_options)
  validate_re($ido_db_host, $host_regex)
  validate_integer($ido_db_port)
  validate_string($ido_db_name)
  validate_string($ido_db_user)
  validate_string($ido_db_pass)
  validate_re($web_db_server, $db_options)
  validate_re($web_db_host, $host_regex)
  validate_integer($web_db_port)
  validate_string($web_db_name)
  validate_string($web_db_user)
  validate_string($web_db_pass)
  validate_re($web_auth_type, $auth_type_options)
  validate_string($web_auth_name)
  validate_absolute_path($web_auth_user_file)
  validate_absolute_path($web_auth_group_file)
  validate_hash($web_auth_users)
  validate_re($ldap_security, $ldap_security_options)
  validate_re($ldap_server, $host_regex)
  validate_string($ldap_firstname)
  validate_string($ldap_lastname)
  validate_string($ldap_email)
  if $ldap_basedn {
    validate_string($ldap_basedn)
  }
  if $ldap_groupdn {
    validate_string($ldap_groupdn)
  }
  if $ldap_binddn {
    validate_string($ldap_binddn)
  }
  if $ldap_bindpw {
    validate_string($ldap_bindpw)
  }
  validate_string($ldap_userattr)
  validate_string($ldap_groupattr)
  if $ldap_filter_extra {
    validate_string($ldap_filter_extra)
  }
  if $ldap_auth_group {
    validate_string($ldap_auth_group)
  }
  validate_absolute_path($nagios_plugins)
  if $nagios_extra_plugins {
    validate_absolute_path($nagios_extra_plugins)
  }
  validate_string($icinga_cmd_grp)
  if $db_password {
    validate_string($db_password)
  }
  if $email_user {
    validate_string($email_user)
  }
  if $email_password {
    validate_string($email_password)
  }
  if $ssl_cert_source {
    validate_absolute_path($ssl_cert_source)
  }
  if $clickatell_api_id {
    validate_string($clickatell_api_id)
  }
  if $clickatell_username {
    validate_string($clickatell_username)
  }
  if $clickatell_password {
    validate_string($clickatell_password)
  }
  validate_bool($is_pbx)
  if $pbx_mngr_pw {
    validate_($pbx_mngr_pw)
  }
  validate_absolute_path($cgi_path)
  validate_absolute_path($html_path)
  if $css_path {
    validate_absolute_path($css_path)
  }
  validate_absolute_path($pnp4nagios_html_path)
  validate_absolute_path($cgi_url)

  if $manage_users {
    include ::icinga::users
    Class['icinga::users'] -> Class['icinga::install']
  }

  include ::icinga::install
  include ::icinga::idoconfig
  include ::icinga::idoservice
  include ::icinga::config
  include ::icinga::nagios_resources
  include ::icinga::service


  Class['icinga::install'] -> Class['icinga::idoconfig']
  Class['icinga::install'] -> Class['icinga::gui']
  Class['icinga::idoconfig'] ~> Class['icinga::idoservice']

  Class['icinga::config'] ~> Class['icinga::service']
  Class['icinga::nagios_resources'] ~> Class['icinga::service']

  include ::icinga::gui

  if ( $perfdata  and $perfdatatype =~ /^pnp4nagios$/ ) {
    include ::pnp4nagios
  }
}
