
class icinga::install {

  include icinga::params

  case $::osfamily {
     "RedHat": {
       ensure_packages(["icinga","icinga-idoutils-libdbi-${icinga::params::ido_db_server}"])
       # package { ['icinga',"icinga-idoutils-libdbi-${icinga::params::ido_db_server}"]:
       #   ensure => installed,
       # }
       if ( $icinga::params::gui_type =~ /^(classic|both)$/ ) {
         ensure_packages(["icinga-gui"])
         #package { 'icinga-gui': ensure => installed }
       }
       if ( $icinga::params::gui_type =~ /^(web|both)$/ ) {
         ensure_packages(["icinga-web","${icinga::params::php_package_prefix}-soap","${icinga::params::php_package_prefix}-gd","php-ldap"])
         #package { 'icinga-web': ensure => installed }
         #package { ['php-soap','php-gd','php-ldap']: ensure => installed }
       }
     }
     "Debian": {
       apt::ppa { 'ppa:formorer/icinga': }
       if $icinga::params::gui_type =~ /^(web|both)$/ {
         apt::ppa { 'ppa:formorer/icinga-web': }
         ensure_packages(["icinga-web"])
         #package { 'icinga-web':
         #  ensure => installed,
         #}
       }
       ensure_packages(["icinga","icinga-idoutils"])
       #package { ['icinga', 'icinga-idoutils']:
       #  ensure => installed,
       #}
     }
     default: {
       fail("Only support Red Hat and Debian type systems, not ${::osfamily}")
     }
   }
}

