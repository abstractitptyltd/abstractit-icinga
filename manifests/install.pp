
class icinga::install {

  include icinga::params
  $ido_db_server = $icinga::params::ido_db_server

  package { ['icinga','icinga-doc','icinga-gui',"icinga-idoutils-libdbi-${ido_db_server}"]:
    ensure => installed,
  }

}

