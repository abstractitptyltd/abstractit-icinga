
class icinga::install {

  include icinga::params

  case $::osfamily {
    'RedHat': {
      ensure_packages(['icinga',"icinga-idoutils-libdbi-${icinga::params::ido_db_server}"])
      if ( $icinga::params::gui_type =~ /^(classic|both)$/ ) {
        ensure_packages(['icinga-gui'])
      }
      if ( $icinga::params::gui_type =~ /^(web|both)$/ ) {
        ensure_packages(['icinga-web','php-soap','php-gd','php-ldap'])
      }
    }
    'Debian': {
      apt::ppa { 'ppa:formorer/icinga': }
      if $icinga::params::gui_type =~ /^(web|both)$/ {
        apt::ppa { 'ppa:formorer/icinga-web': }
        ensure_packages(['icinga-web'])
        if ! defined(Apache::Mod['authn_file']) {
          apache::mod{'authn_file':}
        }
      }
      ensure_packages(['icinga','icinga-idoutils'])
      }
    default: {
      fail("Only support Red Hat and Debian type systems, not ${::osfamily}")
    }
  }
}

