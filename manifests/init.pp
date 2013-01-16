
class icinga {
  include icinga::params
	include icinga::install
  include icinga::config
  include icinga::idoservice
  include icinga::service
  include icinga::gui
  #	include icinga::scripts
}
