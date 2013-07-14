#
class icinga::install {

  include icinga::params

  case $::osfamily {
    'RedHat': {
      package { ['icinga',"icinga-idoutils-libdbi-${icinga::params::ido_db_server}"]:
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
    'Debian': {
      apt::ppa { 'ppa:formorer/icinga': }
      if $icinga::params::gui_type =~ /^(web|both)$/ {
        apt::ppa { 'ppa:formorer/icinga-web': }
        package { 'icinga-web':
          ensure => installed,
        }
      }
      package { ['icinga', 'icinga-idoutils']:
        ensure => installed,
      }
    }
    default: {
      fail("Only support Red Hat and Debian type systems, not ${::osfamily}")
    }
  }
}

