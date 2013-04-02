
class icinga::install {

  include icinga::params
  $ido_db_server = $icinga::params::ido_db_server

  package { ['icinga',"icinga-idoutils-libdbi-${ido_db_server}"]:
    ensure => installed,
  }
  if ( $icinga::params::gui_type =~ /^(classic|both)$/ ) { 
      package { 'icinga-gui': ensure => installed }
  }
  if ( $icinga::params::gui_type =~ /^(web|both)$/ ) { 
      package { 'icinga-web': ensure => installed }
      package { ['php-soap','php-gd','php-ldap','php-mysql']: ensure => installed }
  }

}

