class icinga::idoservice {

  service { 'ido2db':
    ensure => running,
    enable => true,
    hasstatus => true,
    hasrestart => true,
    require => Class[icinga::config],
  }

}
