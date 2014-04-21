# Class icinga::idoconfig
#
# setuop ido for icinga

class icinga::idoconfig {

  include icinga::params

  $ido_db_server = $icinga::params::ido_db_server
  $ido_db_host = $icinga::params::ido_db_host
  # check if we are running pgsql and fix port if it is set to default mysql port
  if $icinga::params::ido_db_server == 'pgsql' and $icinga::params::ido_db_port == 3306 {
    $ido_db_port = 5432
  } else {
    $ido_db_port = $icinga::params::ido_db_port
  }
  $ido_db_name = $icinga::params::ido_db_name
  $ido_db_user = $icinga::params::ido_db_user
  $ido_db_pass = $icinga::params::ido_db_pass
  # db install file lives here
  # /usr/share/doc/icinga-idoutils-libdbi-mysql-$ICINGA_VERSION/db/${icinga::params::ido_db_server}

  file { '/etc/icinga/ido2db.cfg':
    owner   => root,
    group   => root,
    mode    => '0660',
    notify  => Class[icinga::idoservice],
    content => template('icinga/ido2db.cfg.erb'),
  }

}

