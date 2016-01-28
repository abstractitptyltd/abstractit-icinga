# Class icinga::idoconfig
#
# setuop ido for icinga
#
# This should not be called directly

class icinga::idoconfig (
  $icinga_user   = $::icinga::icinga_user,
  $icinga_group  = $::icinga::icinga_group,
  $ido_db_server = $::icinga::ido_db_server,
  $ido_db_host   = $::icinga::ido_db_host,
  $ido_db_name   = $::icinga::ido_db_name,
  $ido_db_user   = $::icinga::ido_db_user,
  $ido_db_pass   = $::icinga::ido_db_pass,
  $ido_db_port   = $::icinga::ido_db_port,
) {

  # db install file lives here
  # /usr/share/doc/icinga-idoutils-libdbi-mysql-$ICINGA_VERSION/db/${icinga::server}

  file { '/etc/init.d/ido2db':
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    source  => 'puppet:///modules/icinga//etc/init.d/ido2db',
    require => Class[icinga::install],
  }

  file { '/etc/icinga/ido2db.cfg':
    owner   => root,
    group   => root,
    mode    => '0660',
    content => template('icinga/etc/icinga/ido2db.cfg.erb'),
    require => Class[icinga::install],
  }

  file { '/var/run/icinga/ido2db.pid':
    ensure => file,
    owner  => $icinga_user,
    group  => $icinga_group,
    mode   => '0644',
  }

}
