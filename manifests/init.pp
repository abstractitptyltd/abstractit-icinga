
class icinga {
  class{'icinga::params':} ->
  class{'icinga::install':} ->
  class{'icinga::idoconfig':} ~>
  class{'icinga::idoservice':} ->
  class{'icinga::config':} ~>
  class{'icinga::service':} ->
  Class["icinga"] 

  case $icinga::params::gui_type {
    'classic': {
      include icinga::gui
    }
    'none': {
      notice("WARNING::: no gui selected")
    }
  }
}
