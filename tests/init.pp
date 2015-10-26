include ::icinga
include ::mysql::server
Class['mysql::server'] -> Class['icinga::idoconfig']
mysql::db {$::icinga::ido_db_name:
  user     => $::icinga::ido_db_user,
  host     => $::icinga::ido_db_host,
  password => $::icinga::ido_db_pass,
  grant    => ['all'],
}
mysql::db {$::icinga::web_db_name:
  user     => $::icinga::web_db_user,
  host     => $::icinga::web_db_host,
  password => $::icinga::web_db_pass,
  grant    => ['all'],
}
exec {'create idodb db':
  command => "/usr/bin/mysql -u${::icinga::ido_db_user} -p${::icinga::ido_db_pass} ${::icinga::ido_db_name} < /usr/share/doc/icinga-idoutils/examples/mysql/mysql.sql",
  unless  => "/usr/bin/mysql -u${::icinga::ido_db_user} -p${::icinga::ido_db_pass} -e'show tables' ${::icinga::ido_db_name} | grep icinga_dbversion",
  require => Mysql::Db[$::icinga::ido_db_name],
}
