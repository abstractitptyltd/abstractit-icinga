class icinga::install {

  if $operatingsystem == 'Ubuntu' {
    apt::ppa { 'ppa:formorer/icinga':
      before => Package[$icinga_packages]
    }
    apt::ppa { 'ppa:formorer/icinga-web':
      before => Package[$ubuntu_web_packages]
    }
  }

  include icinga::params
  $ido_db_server = $icinga::params::ido_db_server

  if $ido_db_server == 'postgresql' {
    $db = 'pgsql'
  }
  else {
    $db = 'mysql'
  }

  $icigna_packages = ['icinga', 'icinga-docs', 'icinga-idoutils', "libdbd-${db}", 'nagios-plugins']

  $ubuntu_web_packages = ['php5', 'php5-cli', 'php-pear', 'php5-xmlrpc', 'php5-xsl', 'php5-gd', 'php5-ldap', "php5-${db}"]

  $default_web_packages = ['php-soap', 'php-gd', 'php-ldap', "php-${db}"]

  package { $icinga_packages:
    ensure => latest,
  }

  if ( $icinga::params::gui_type =~ /^(classic|both)$/ ) { 
    package { 'icinga-gui': ensure => latest }
  }

  if ( $icinga::params::gui_type =~ /^(web|both)$/ ) { 
    package { 'icinga-web': ensure => latest }
    case $operatingsystem {
      'Ubuntu': { package { $ubuntu_web_packages:
                    ensure => latest,
                  }
                }
      default: { package { $default_web_packages:
                    ensure => latest, } }
    }
  }
}

