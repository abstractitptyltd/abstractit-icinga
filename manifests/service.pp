# Class icinga::service
#
# manages the the icinga service

class icinga::service {

  case $::lsbdistdescription {
    ## some tricky logic to use systemd on fedora 17+
    /Fedora release (.+)/: {
      if versioncmp($1,'17') >= 0 {
        $servicename = 'icinga.service'
        $provider    = 'systemd'
        $restart     = "systemctl reload ${servicename}"
      }
    }
    default: {
      $servicename = 'icinga'
      $provider    = undef
      $restart     = '/etc/init.d/icinga reload'
    }
  }
  service { 'icinga':
    ensure     => running,
    name       => $servicename,
    provider   => $provider,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
    restart    => $restart,
    require    => [Class['icinga::config'],Class['icinga::idoservice']],
  }

}

