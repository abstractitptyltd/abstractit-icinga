# Class icinga::install
#
# install necessicary packages for icinga

class icinga::install {

  include icinga::params

  case $::osfamily {
    'RedHat': {
      if ($::operatingsystem != 'Fedora') {
        yumrepo { "icinga-stable-release-${::operatingsystemmajrelease}":
          enabled  => 1,
          baseurl  => "http://packages.icinga.org/epel/${::operatingsystemmajrelease}/release/",
          gpgcheck => 1,
          gpgkey   => 'http://packages.icinga.org/icinga.key',
        }
      }
      package { ['icinga',"icinga-idoutils-libdbi-${icinga::params::ido_db_server}"]:
        ensure  => present,
        require => $::operatingsystem ? {
          'Fedora' => undef,
          default  => Yumrepo["icinga-stable-release-${::operatingsystemmajrelease}"],
        }
      }
#      ensure_packages(['icinga',"icinga-idoutils-libdbi-${icinga::params::ido_db_server}"])
      if ( $icinga::params::gui_type =~ /^(classic|both)$/ ) {
        package { 'icinga-gui':
          ensure  => present,
          require => $::operatingsystem ? {
            'Fedora' => undef,
            default  => Yumrepo["icinga-stable-release-${::operatingsystemmajrelease}"],
          }
        }
#        ensure_packages(['icinga-gui'])
      }
      if ( $icinga::params::gui_type =~ /^(web|both)$/ ) {
        package { ['icinga-web','php-soap','php-gd','php-ldap']:
          ensure => present,
        }
#        ensure_packages(['icinga-web','php-soap','php-gd','php-ldap'])
      }
    }
    'Debian': {
      include apt
      apt::ppa { 'ppa:formorer/icinga': }
      if $icinga::params::gui_type =~ /^(web|both)$/ {
        apt::ppa { 'ppa:formorer/icinga-web': }
        package { 'icinga-web':
          ensure  => present,
          require => Apt::Ppa['ppa:formorer/icinga-web'],
        }
#        ensure_packages(['icinga-web'])
        if ! defined(Apache::Mod['authn_file']) {
          apache::mod{'authn_file':}
        }
      }
      package { ['icinga','icinga-idoutils']:
        ensure  => present,
        require => Apt::Ppa['ppa:formorer/icinga'],
      }
#      ensure_packages(['icinga','icinga-idoutils'])
      }
    default: {
      fail("Only support Red Hat and Debian type systems, not ${::osfamily}")
    }
  }
}

