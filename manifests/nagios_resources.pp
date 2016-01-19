# Class icinga::config
#
# create config files for nagios exported resources so config will load
# should not be called directly
class icinga::nagios_resources (
) {

  $icinga_user  = $::icinga::icinga_user
  $icinga_group = $::icinga::icinga_group

  $nagios_resource_files = [
    '/etc/nagios/nagios_command.cfg',
    '/etc/nagios/nagios_contact.cfg',
    '/etc/nagios/nagios_contactgroup.cfg',
    '/etc/nagios/nagios_host.cfg',
    '/etc/nagios/nagios_hostdependency.cfg',
    '/etc/nagios/nagios_hostescalation.cfg',
    '/etc/nagios/nagios_hostgroup.cfg',
    '/etc/nagios/nagios_service.cfg',
    '/etc/nagios/nagios_servicedependency.cfg',
    '/etc/nagios/nagios_serviceescalation.cfg',
    '/etc/nagios/nagios_servicegroup.cfg',
    '/etc/nagios/nagios_timeperiod.cfg'
  ]
  file { '/etc/nagios':
    ensure => directory,
    owner  => $icinga_user,
    group  => $icinga_group,
  }
  file {$nagios_resource_files:
    ensure => present,
    owner  => $icinga_user,
    group  => $icinga_group,
  }
}

