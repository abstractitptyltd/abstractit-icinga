# Class icinga
#
# setup icinga
# full docs in README.md

class icinga {
  include icinga::users
  include icinga::install
  include icinga::idoconfig
  include icinga::idoservice
  include icinga::config
  include icinga::service

  Class['icinga::users'] ->
  Class['icinga::install']

  Class['icinga::idoconfig'] ~>
  Class['icinga::idoservice']

  Class['icinga::config'] ~>
  Class['icinga::service'] ->
  Class['icinga']

  if ( $icinga::params::gui_type =~ /^(classic|web|both)$/ ) {
    include icinga::gui
  } else {
    notice('no gui selected')
  }
  if ( $icinga::params::perfdata == true and $icinga::params::perfdatatype =~ /^pnp4nagios$/ ) {
    include pnp4nagios
  }
}
