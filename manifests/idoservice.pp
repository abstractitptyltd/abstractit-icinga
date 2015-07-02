# Class icinga::idoservice
#
# manages the the ido service for icinga

class icinga::idoservice {

  $enable = $::icinga::enable_ido

  case $enable {
    default: {
      $ensure = 'running'
    }
    false: {
      $ensure = 'stopped'
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
    ensure     => $ensure,
    name       => $servicename,
    provider   => $provider,
    enable     => $enable,
    hasstatus  => true,
    hasrestart => true,
    require    => Class[icinga::idoconfig],
  }
}
