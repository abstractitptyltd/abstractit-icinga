# Class icinga::install
#
# install necessicary packages for icinga

class icinga::install {

  $ido_db_server = $::icinga::ido_db_server
  $manage_repo   = $::icinga::manage_repo
  $gui_type      = $::icinga::gui_type

  case $::osfamily {
    'RedHat' : {
      $packages = [ 'icinga', "icinga-idoutils-libdbi-${ido_db_server}"]
      if ($::operatingsystem != 'Fedora' and $manage_repo) {
        yumrepo { "icinga-stable-release-${::operatingsystemmajrelease}":
          enabled  => 1,
          baseurl  => "http://packages.icinga.org/epel/${::operatingsystemmajrelease}/release/",
          gpgcheck => 1,
          gpgkey   => 'http://packages.icinga.org/icinga.key',
        }
        $package_require = Yumrepo["icinga-stable-release-${::operatingsystemmajrelease}"]
      } else {
        $package_require = undef
      }
      case $gui_type {
        'classic':  {
          $web_packages         = ['icinga-gui']
          $web_packages_require = $package_require
        } 'web': {
          $web_packages         = ['icinga-web', 'php-soap', 'php-gd', 'php-ldap' ]
          $web_packages_require = $package_require
        } 'both': {
          $web_packages         = ['icinga-gui', 'icinga-web', 'php-soap', 'php-gd', 'php-ldap' ]
          $web_packages_require = $package_require
        } default: {
          $web_packages         = undef
          $web_packages_require = undef
        }
      }
    }
    'Debian' : {
      $packages = ['icinga', 'icinga-idoutils']
      if $manage_repo {
        include ::apt
        apt::ppa { 'ppa:formorer/icinga': }
        $package_require = Apt::Ppa['ppa:formorer/icinga']
      } else {
        $package_require = undef
      }
      if $gui_type =~ /^(web|both)$/ {
        if $manage_repo {
          apt::ppa { 'ppa:formorer/icinga-web': }
          $web_packages_require = Apt::Ppa['ppa:formorer/icinga-web']
        }
        $web_packages = 'icinga-web'
      } else {
          $web_packages         = undef
          $web_packages_require = undef
      }
    }
    default  : {
      fail("Only support Red Hat and Debian type systems, not ${::osfamily}")
    }
  }
  package { $packages:
    ensure  => present,
    require => $package_require
  }
  if $web_packages {
    package { $web_packages:
      ensure  => present,
      require => $web_packages_require
    }
  }
}

