
class icinga::service {
  include icinga::params
  service { 'icinga':
    ensure => running,
    enable => true,
    hasstatus => true,
    hasrestart => true,
    restart => '/etc/init.d/icinga reload',
    require => Class[icinga::idoservice],
  }

}

