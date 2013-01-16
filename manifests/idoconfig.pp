
class icinga::idoconfig {

  include icinga::params

  $ido_db_host = $icinga::params::ido_db_host
  $ido_db_port = $icinga::params::ido_db_port
  $ido_db_name = $icinga::params::ido_db_name
  $ido_db_user = $icinga::params::ido_db_user
  $ido_db_pass = $icinga::params::ido_db_pass

  file { 'ido2dbcfg':
    name => '/etc/icinga/ido2db.cfg',
    owner => root,
    group => root,
    mode => 660,
    notify => Class[icinga::idoservice],
    content => template('icinga/ido2db.cfg.erb'),
  }

}

