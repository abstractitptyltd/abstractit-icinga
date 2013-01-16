
class icinga::params (
  $web_ip = $ipaddress,
  $web_port = 443,
  $ssl = true,
  $webhostname = $fqdn,
  $notifications = 1,
  $embedded_perl = 0,
  $admin_group = undef,
  $admin_users = undef,
  $ro_users = undef,
  $ro_group = undef,
  $check_timeout = 180,
  $ido_db_host = 'localhost',
  $ido_db_port = 3306,
  $ido_db_name = 'icinga',
  $ido_db_user = 'icinga',
  $ido_db_pass = 'icinga',
  $debug = 0,
  $admin_email = 'icinga@localhost',
  $admin_pager = 'pageicinga@localhost',
  $stalking = 0,
  $flap_detection = 1,
) {
  $nagios_plugins = $architecture ? { 'x86_64' => '/usr/lib64/nagios/plugins', default => '/usr/lib/nagios/plugins'}
  $nagios_extra_plugins = hiera('monitoring::params::nagios_extra_plugins', undef)
  $icinga_cmd_grp = 'icingacmd'
  $db_password = hiera('monitoring::db_password')
  $email_user = hiera('monitoring::email_user')
  $email_password = hiera('monitoring::email_password')
  $apache_ssl_dir = hiera('apache_ssl_dir', '/etc/httpd/ssl')
  $apache_log_dir = hiera('apache_log_dir', '/var/log/httpd')
}

