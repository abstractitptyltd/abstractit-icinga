# Class icinga::config
#
# Configures icinga using the defaults set in the params class
# should not be called directly
class icinga::config {
  $icinga_user          = $::icinga::icinga_user
  $icinga_group         = $::icinga::icinga_group
  $icinga_cmd_grp       = $::icinga::icinga_cmd_grp
  $notifications        = $::icinga::notifications
  $enable_ido           = $::icinga::enable_ido
  $embedded_perl        = $::icinga::embedded_perl
  $perfdata             = $::icinga::perfdata
  $perfdatatype         = $::icinga::perfdatatype
  $admin_group          = $::icinga::admin_group
  $nagios_plugins       = $::icinga::nagios_plugins
  $nagios_extra_plugins = $::icinga::nagios_extra_plugins
  $db_password          = $::icinga::db_password
  $email_password       = $::icinga::email_password
  $check_timeout        = $::icinga::check_timeout
  $clickatell_api_id    = $::icinga::clickatell_api_id
  $clickatell_username  = $::icinga::clickatell_username
  $clickatell_password  = $::icinga::clickatell_password
  $is_pbx               = $::icinga::is_pbx
  $pbx_mngr_pw          = $::icinga::pbx_mngr_pw
  $debug                = $::icinga::debug
  $admin_email          = $::icinga::admin_email
  $admin_pager          = $::icinga::admin_pager
  $stalking             = $::icinga::stalking
  $flap_detection       = $::icinga::flap_detection

  $ensure_idoutils = $enable_ido? {
    default => 'file',
    false => 'absent',
  }

  $ensure_perf_mod = $perfdata? {
    default => 'file',
    false => 'absent',
  }

  file { '/etc/default/icinga':
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('icinga/etc/default/icinga.erb'),
    notify  => [Class[icinga::service],Class[icinga::idoservice]],
    require => Class[icinga::install],
  }

  file { '/etc/icinga/icinga.cfg':
    owner   => $icinga_user,
    group   => $icinga_group,
    mode    => '0644',
    notify  => Class[icinga::service],
    content => template('icinga/etc/icinga/icinga.cfg.erb'),
    require => Class[icinga::install],
  }

  file { '/etc/icinga/modules/perf_module.cfg':
    ensure  => $ensure_perf_mod,
    owner   => $icinga_user,
    group   => $icinga_group,
    mode    => '0644',
    notify  => Class[icinga::service],
    source  => 'puppet:///modules/icinga/etc/icinga/modules/perf_module.cfg',
    require => Class[icinga::install],
  }

  file { '/etc/icinga/modules/idoutils.cfg':
    ensure  => $ensure_idoutils,
    owner   => $icinga_user,
    group   => $icinga_group,
    mode    => '0644',
    notify  => Class[icinga::service],
    source  => 'puppet:///modules/icinga/etc/icinga/modules/idoutils.cfg',
    require => Class[icinga::install],
  }

  file { '/etc/icinga/idoutils.cfg':
    owner   => $icinga_user,
    group   => $icinga_group,
    mode    => '0644',
    notify  => Class[icinga::service],
    source  => 'puppet:///modules/icinga/etc/icinga/idoutils.cfg',
    require => Class[icinga::install],
  }
  file { '/etc/icinga/resource.cfg':
    owner   => $icinga_user,
    group   => $icinga_group,
    mode    => '0644',
    notify  => Class[icinga::service],
    content => template('icinga/etc/icinga/resource.cfg.erb'),
    require => Class[icinga::install],
  }

  file { '/etc/icinga/conf.d':
    ensure  => directory,
    owner   => $icinga_user,
    group   => $icinga_group,
    mode    => '0775',
    require => Class[icinga::install],
  }

  file { '/var/log/icinga':
    ensure => directory,
    owner  => $icinga_user,
    group  => $icinga_group,
    mode   => '0775',
  }

  file { '/var/log/icinga/archives':
    ensure  => directory,
    owner   => $icinga_user,
    group   => $icinga_group,
    mode    => '0775',
    require => File['/var/log/icinga']
  }

  file { '/var/spool/icinga':
    ensure => directory,
    owner  => $icinga_user,
    group  => $icinga_group,
    mode   => '0755',
  }

  file { '/var/spool/icinga/checkresults':
    ensure  => directory,
    owner   => $icinga_user,
    group   => $icinga_group,
    mode    => '0775',
    require => File['/var/spool/icinga']
  }

  file { '/var/spool/icinga/cmd':
    ensure  => directory,
    owner   => $icinga_user,
    group   => $icinga_cmd_grp,
    mode    => '2755',
    require => File['/var/spool/icinga']
  }

  file { '/var/run/icinga':
    ensure => directory,
    owner  => $icinga_user,
    group  => $icinga_group,
    mode   => '0775',
  }

  file { '/var/run/icinga/icinga.pid':
    ensure  => file,
    owner   => $icinga_user,
    group   => $icinga_group,
    mode    => '0644',
    require => File['/var/run/icinga']
  }
}

