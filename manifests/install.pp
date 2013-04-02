
class icinga::install {

  include icinga::params
  $ido_db_server = $icinga::params::ido_db_server

  package { ['icinga',"icinga-idoutils-libdbi-${ido_db_server}"]:
    ensure => installed,
  }
  case $icinga::params::gui_type {
    classic: {
      package { 'icinga-gui': ensure => installed }
    }
    new: {
      package { 'icinga-web': ensure => installed }
      package { ['php-soap','php-gd','php-ldap','php-mysql']: ensure => installed }
    }
  }

}

