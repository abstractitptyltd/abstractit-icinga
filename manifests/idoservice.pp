# Class icinga::idoservice
#
# manages the the ido service for icinga

class icinga::idoservice {

  include icinga::params
  $enable_ido = $icinga::params::enable_ido
  case $enable_ido {
    default: {
      $ido_enable = true
      $ido_ensure = 'running'
    }
    false: {
      $ido_enable = false
      $ido_ensure = 'stopped'
    }
  }

  case $::lsbdistdescription {
    ## some tricky logic to use systemd on fedora 17+
    /Fedora release (.+)/: {
      if versioncmp($1,'17') >= 0 {
        $servicename = 'ido2db.service'
        $provider = 'systemd'
      }
    }
    default: {
      $servicename = 'ido2db'
      $provider = undef
    }
  }
  service { 'ido2db':
    ensure     => $ido_ensure,
    name       => $servicename,
    provider   => $provider,
    enable     => $ido_enable,
    hasstatus  => true,
    hasrestart => true,
    require    => Class[icinga::idoconfig],
  }

}
