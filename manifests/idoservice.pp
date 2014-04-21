# Class icinga::idoservice
#
# manages the the ido service for icinga

class icinga::idoservice {

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
    ensure     => running,
    name       => $servicename,
    provider   => $provider,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
    require    => Class[icinga::idoconfig],
  }

}
