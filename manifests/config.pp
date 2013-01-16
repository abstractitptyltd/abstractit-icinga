
class icinga::config {

  include icinga::params

  $notifications = $icinga::params::notifications
  $embedded_perl = $icinga::params::embedded_perl
  $admin_group = $icinga::params::admin_group
  $nagios_plugins = $icinga::params::nagios_plugins
  $nagios_extra_plugins = $icinga::config::nagios_extra_plugins
  $db_password = $icinga::params::db_password
  $email_password = $icinga::params::email_password
  $check_timeout = $icinga::params::check_timeout
  $clickatell_api_id = hiera('monitoring::clickatell_api_id', undef)
  $clickatell_username = hiera('monitoring::clickatell_username', undef)
  $clickatell_password = hiera('monitoring::clickatell_password', undef)
  $is_pbx = hiera('is_pbx', false)
  $pbx_mngr_pw = hiera('monitoring::pbx_mngr_pw', undef)
  $ido_db_host = $icinga::params::ido_db_host
  $ido_db_port = $icinga::params::ido_db_port
  $ido_db_name = $icinga::params::ido_db_name
  $ido_db_user = $icinga::params::ido_db_user
  $ido_db_pass = $icinga::params::ido_db_pass
  $debug = $icinga::params::debug
  $admin_email = $icinga::params::admin_email
  $admin_pager = $icinga::params::admin_pager
  $stalking = $icinga::params::stalking
  $flap_detection = $icinga::params::flap_detection

  file { 'icingacfg':
    name => '/etc/icinga/icinga.cfg',
    owner => icinga,
    group => icinga,
    mode => 644,
    notify => Class[icinga::service],
    content => template('icinga/icinga.cfg.erb'),
  }

  file { 'idomodcfg':
    name => '/etc/icinga/idomod.cfg',
    owner => icinga,
    group => icinga,
    mode => 644,
    notify => Class[icinga::service],
    content => template('icinga/idomod.cfg.erb'),
  }

  file { 'ido2dbcfg':
    name => '/etc/icinga/ido2db.cfg',
    owner => root,
    group => root,
    mode => 660,
    notify => Class[icinga::idoservice],
    content => template('icinga/ido2db.cfg.erb'),
  }

  file { 'icinga_resource':
    name => '/etc/icinga/resource.cfg',
    owner => icinga,
    group => icinga,
    mode => 644,
    notify => Class[icinga::service],
    content => template('icinga/resource.cfg.erb'),
  }

  file { '/var/log/icinga':
    ensure => directory,
    owner => icinga,
    group => icinga,
    mode => 775,
  }

  file { '/var/log/icinga/archives':
    ensure => directory,
    owner => icinga,
    group => icinga,
    mode => 775,
  }

  file { '/var/spool/icinga':
    ensure => directory,
    owner => icinga,
    group => icinga,
    mode => 755,
  }

  file { '/var/spool/icinga/checkresults':
    ensure => directory,
    owner => icinga,
    group => icinga,
    mode => 775,
  }

  file { '/var/spool/icinga/cmd':
    ensure => directory,
    owner => icinga,
    group => icingacmd,
    mode => 2755,
  }

}

