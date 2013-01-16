
class icinga::install {

  include icinga::params

  package { ['icinga','icinga-doc','icinga-gui','icinga-idoutils-libdbi-mysql']:
    ensure => installed,
  }

}

