#
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

  $restart_provider = $provider ? {
    default   => '/etc/init.d/icinga reload',
    'systemd' => "systemctl reload ${servicename}"
  }

  service { 'icinga':
    ensure     => running,
    name       => $servicename,
    provider   => $provider,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
    restart    => $restart_provider,
    require    => Class[icinga::idoservice],
  }

}

