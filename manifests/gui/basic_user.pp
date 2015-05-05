# Class icinga::gui
#
# Configures the icinga gui

define icinga::gui::basic_user (
  $password = undef
) {
  $web_auth_user_file  = $::icinga::web_auth_user_file
  exec {"create gui::basic_user ${name}":
    user    => $::apache::user,
    command => "/usr/bin/htpasswd -b ${web_auth_user_file} ${name} ${password}",
    unless  => "/bin/grep ^${name}: ${web_auth_user_file}",
  }
}
