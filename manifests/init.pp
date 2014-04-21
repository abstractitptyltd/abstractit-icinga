# Class icinga
#
# setup icinga
# full docs in README.md

class icinga {
  class{'icinga::params':} ->
  class{'icinga::install':} ->
  class{'icinga::users':} ->
  class{'icinga::idoconfig':} ~>
  class{'icinga::idoservice':} ->
  class{'icinga::config':} ~>
  class{'icinga::service':} ->
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
