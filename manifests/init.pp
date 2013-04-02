
class icinga {
  class{'icinga::params':} ->
  class{'icinga::install':} ->
  class{'icinga::idoconfig':} ~>
  class{'icinga::idoservice':} ->
  class{'icinga::config':} ~>
  class{'icinga::service':} ->
  Class["icinga"] 

  if ( $icinga::params::gui_type =~ /^(classic|web|both)$/ ) {
    include icinga::gui
  } else {
    notice("no gui selected")
  }
}
