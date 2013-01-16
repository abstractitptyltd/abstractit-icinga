
class icinga {
  class{'icinga::params':} ->
  class{'icinga::install':} ->
  class{'icinga::idoconfig':} ~>
  class{'icinga::idoservice':} ->
  class{'icinga::config':} ~>
  class{'icinga::service':} ->
  class{'icinga::gui':} ->
  Class["icinga"] 
}
