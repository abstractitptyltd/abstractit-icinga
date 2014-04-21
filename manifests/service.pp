# Class icinga::service
#
# manages the the icinga service

class icinga::service {

  case $::lsbdistdescription {
    ## some tricky logic to use systemd on fedora 17+
    /Fedora release (.+)/: {
      if versioncmp($1,'17') >= 0 {
        $servicename = 'icinga.service'
        $provider = 'systemd'
      }
    }
    default: {
      $servicename = 'icinga'
      $provider = undef
    }
  }
  service { 'icinga':
    ensure     => running,
    name       => $servicename,
    provider   => $provider,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
    restart    => $provider ? {
      default   => '/etc/init.d/icinga reload',
      'systemd' => "systemctl reload ${servicename}"
    },
    require    => Class[icinga::idoservice],
  }

}

