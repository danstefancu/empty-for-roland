# Defines where we can expect PHP ini files and paths to be located.
#
# Different OS, OS version, webserver and PHP versions all contributes
# to making a mess of where we can expect INI files to be found.
#
# I have listed a bunch of places:
#
# 5.3
#     CENTOS 6
#         CLI   /etc/php.d
#         FPM   /etc/php.d
# 5.4
#     CENTOS 6
#         CLI   /etc/php.d
#         FPM   /etc/php.d
#     DEBIAN 6 SQUEEZE, DEBIAN 7 WHEEZY, UBUNTU 10.04 LUCID, UBUNTU 12.04 PRECISE
#         CLI   /etc/php5/cli/conf.d  -> /etc/php5/conf.d/*  -> /etc/php5/mods-available/*
#         FPM   /etc/php5/fpm/conf.d  -> /etc/php5/conf.d/*  -> /etc/php5/mods-available/*
# 5.5
#     CENTOS 6
#         CLI   /etc/php.d
#         FPM   /etc/php.d
#     DEBIAN 7 WHEEZY, UBUNTU 12.04 PRECISE
#         CLI   /etc/php5/cli/conf.d/*  -> /etc/php5/mods-available/*
#         FPM   /etc/php5/fpm/conf.d/*  -> /etc/php5/mods-available/*
#     UBUNTU 14.04 TRUSTY
#         CLI   /etc/php5/cli/conf.d/*  -> /etc/php5/conf.d/*
#         FPM   /etc/php5/fpm/conf.d/*  -> /etc/php5/mods-available/*
# 5.6
#     CENTOS 6
#         CLI   /etc/php.d
#         FPM   /etc/php.d
#     DEBIAN 7 WHEEZY
#         CLI   /etc/php5/cli/conf.d/*  -> /etc/php5/mods-available/*
#         FPM   /etc/php5/fpm/conf.d/*  -> /etc/php5/mods-available/*
#     UBUNTU 14.04 TRUSTY
#         CLI   /etc/php/5.6/cli/conf.d/* -> /etc/php/mods-available/*
#         FPM   /etc/php/5.6/fpm/conf.d/* -> /etc/php/mods-available/*
# 7.0
#     CENTOS 6
#          N/A
#     UBUNTU 14.04 TRUSTY
#         CLI   /etc/php/7.0/cli/conf.d/*  -> /etc/php/mods-available/*
#         FPM   /etc/php/7.0/fpm/conf.d/*  -> /etc/php/mods-available/*
#
define puphpet::php::ini (
  $php_version,
  $webserver,
  $ini_filename = 'zzzz_custom.ini',
  $entry,
  $value  = '',
  $ensure = present
  ) {

  $real_webserver = $webserver ? {
    'apache'     => 'fpm',
    'httpd'      => 'fpm',
    'apache2'    => 'fpm',
    'nginx'      => 'fpm',
    'php53u-fpm' => 'php53u-fpm',
    'php5-fpm'   => 'fpm',
    'php5.6-fpm' => 'fpm',
    'php7-fpm'   => 'php7-fpm',
    'php7.0-fpm' => 'fpm',
    'php-fpm'    => 'fpm',
    'fpm'        => 'fpm',
    'cgi'        => 'cgi',
    'fcgi'       => 'cgi',
    'fcgid'      => 'cgi',
    undef        => undef,
  }

  case $php_version {
    '5.3', '53': {
      case $::osfamily {
        'redhat': {
          $target_dir  = '/etc/php.d'
          $target_file = "${target_dir}/${ini_filename}"

          if ! defined(File[$target_file]) {
            file { $target_file:
              replace => no,
              ensure  => present,
            }
          }
        }
        default: { fail('This OS has not yet been defined for PHP 5.3!') }
      }
    }
    '5.4', '54': {
      case $::osfamily {
        'debian': {
          $target_dir  = '/etc/php5/mods-available'
          $target_file = "${target_dir}/${ini_filename}"

          if ! defined(File[$target_file]) {
            file { $target_file:
              replace => no,
              ensure  => present,
            }
          }

          $symlink = "/etc/php5/conf.d/${ini_filename}"

          if ! defined(File[$symlink]) {
            file { $symlink:
              ensure  => link,
              target  => $target_file,
              require => File[$target_file],
            }
          }
        }
        'redhat': {
          $target_dir  = '/etc/php.d'
          $target_file = "${target_dir}/${ini_filename}"

          if ! defined(File[$target_file]) {
            file { $target_file:
              replace => no,
              ensure  => present,
            }
          }
        }
        default: { fail('This OS has not yet been defined for PHP 5.4!') }
      }
    }
    '5.5', '55': {
      case $::osfamily {
        'debian': {
          $target_dir  = '/etc/php5/mods-available'
          $target_file = "${target_dir}/${ini_filename}"

          $webserver_ini_location = $real_webserver ? {
              'apache2' => '/etc/php5/apache2/conf.d',
              'cgi'     => '/etc/php5/cgi/conf.d',
              'fpm'     => '/etc/php5/fpm/conf.d',
              undef     => undef,
          }
          $cli_ini_location = '/etc/php5/cli/conf.d'

          if ! defined(File[$target_file]) {
            file { $target_file:
              replace => no,
              ensure  => present,
            }
          }

          $symlink = "/etc/php5/conf.d"

          if ! defined(File[$symlink]) {
            file { $symlink:
              ensure  => link,
              target  => $target_dir,
              require => File[$target_file],
            }
          }

          if $webserver_ini_location != undef and ! defined(File["${webserver_ini_location}/${ini_filename}"]) {
            file { "${webserver_ini_location}/${ini_filename}":
              ensure  => link,
              target  => $target_file,
              require => File[$target_file],
            }
          }

          if ! defined(File["${cli_ini_location}/${ini_filename}"]) {
            file { "${cli_ini_location}/${ini_filename}":
              ensure  => link,
              target  => $target_file,
              require => File[$target_file],
            }
          }
        }
        'redhat': {
          $target_dir  = '/etc/php.d'
          $target_file = "${target_dir}/${ini_filename}"

          if ! defined(File[$target_file]) {
            file { $target_file:
              replace => no,
              ensure  => present,
            }
          }
        }
        default: { fail('This OS has not yet been defined for PHP 5.5/5.6!') }
      }
    }
    '5.6', '56': {
      case $::osfamily {
        'debian': {
          case $::operatingsystem {
            'debian': {
              $target_dir  = '/etc/php5/mods-available'
              $target_file = "${target_dir}/${ini_filename}"

              $webserver_ini_location = $real_webserver ? {
                'apache2' => '/etc/php5/apache2/conf.d',
                'cgi'     => '/etc/php5/cgi/conf.d',
                'fpm'     => '/etc/php5/fpm/conf.d',
                undef     => undef,
              }
              $cli_ini_location = '/etc/php5/cli/conf.d'

              if ! defined(File[$target_file]) {
                file { $target_file:
                  replace => no,
                  ensure  => present,
                }
              }

              $symlink = "/etc/php5/conf.d"

              if ! defined(File[$symlink]) {
                file { $symlink:
                  ensure  => link,
                  target  => $target_dir,
                  require => File[$target_file],
                }
              }

              if $webserver_ini_location != undef and ! defined(File["${webserver_ini_location}/${ini_filename}"]) {
                file { "${webserver_ini_location}/${ini_filename}":
                  ensure  => link,
                  target  => $target_file,
                  require => File[$target_file],
                }
              }

              if ! defined(File["${cli_ini_location}/${ini_filename}"]) {
                file { "${cli_ini_location}/${ini_filename}":
                  ensure  => link,
                  target  => $target_file,
                  require => File[$target_file],
                }
              }
            }
            'ubuntu': {
              $target_dir  = '/etc/php/5.6/mods-available'
              $target_file = "${target_dir}/${ini_filename}"

              $webserver_ini_location = $real_webserver ? {
                'apache2' => '/etc/php/5.6/apache2/conf.d',
                'cgi'     => '/etc/php/5.6/cgi/conf.d',
                'fpm'     => '/etc/php/5.6/fpm/conf.d',
                undef     => undef,
              }
              $cli_ini_location = '/etc/php/5.6/cli/conf.d'

              if ! defined(File[$target_file]) {
                file { $target_file:
                  replace => no,
                  ensure  => present,
                }
              }

              if $webserver_ini_location != undef and ! defined(File["${webserver_ini_location}/${ini_filename}"]) {
                file { "${webserver_ini_location}/${ini_filename}":
                  ensure  => link,
                  target  => $target_file,
                  require => File[$target_file],
                }
              }

              if ! defined(File["${cli_ini_location}/${ini_filename}"]) {
                file { "${cli_ini_location}/${ini_filename}":
                  ensure  => link,
                  target  => $target_file,
                  require => File[$target_file],
                }
              }
            }
          }
        }
        'redhat': {
          $target_dir  = '/etc/php.d'
          $target_file = "${target_dir}/${ini_filename}"

          if ! defined(File[$target_file]) {
            file { $target_file:
              replace => no,
              ensure  => present,
            }
          }
        }
        default: { fail('This OS has not yet been defined for PHP 5.5/5.6!') }
      }
    }
    '7.0', '70': {
      case $::osfamily {
        'debian': {
          case $::operatingsystem {
            'debian': {
              fail('PHP 7 support for Debian not yet added.')
            }
            'ubuntu': {
              $target_dir  = '/etc/php/7.0/mods-available'
              $target_file = "${target_dir}/${ini_filename}"

              $webserver_ini_location = $real_webserver ? {
                'cgi' => '/etc/php/7.0/cgi/conf.d',
                'fpm' => '/etc/php/7.0/fpm/conf.d',
                undef => undef,
              }
              $cli_ini_location = '/etc/php/7.0/cli/conf.d'

              if ! defined(File[$target_file]) {
                file { $target_file:
                  replace => no,
                  ensure  => present,
                }
              }

              if $webserver_ini_location != undef and ! defined(File["${webserver_ini_location}/${ini_filename}"]) {
                file { "${webserver_ini_location}/${ini_filename}":
                  ensure  => link,
                  target  => $target_file,
                  require => File[$target_file],
                }
              }

              if ! defined(File["${cli_ini_location}/${ini_filename}"]) {
                file { "${cli_ini_location}/${ini_filename}":
                  ensure  => link,
                  target  => $target_file,
                  require => File[$target_file],
                }
              }
            }
          }
        }
        'redhat': {
          $target_dir  = '/etc/php.d'
          $target_file = "${target_dir}/${ini_filename}"

          if ! defined(File[$target_file]) {
            file { $target_file:
              replace => no,
              ensure  => present,
            }
          }
        }
        default: { fail('This OS has not yet been defined for PHP 7.0!') }
      }
    }
    default: { fail('Unrecognized PHP version') }
  }

  if $real_webserver != undef {
    $notify_service = Service[$webserver]
  } else {
    $notify_service = []
  }

  if '=' in $value {
    $changes = $ensure ? {
      present => [ "set '${entry}' \"'${value}'\"" ],
      absent  => [ "rm \"'${entry}'\"" ],
    }
  } else {
    $changes = $ensure ? {
      present => [ "set '${entry}' '${value}'" ],
      absent  => [ "rm '${entry}'" ],
    }
  }

  augeas { "${entry}: ${value}":
    lens    => 'PHP.lns',
    incl    => $target_file,
    changes => $changes,
    notify  => $notify_service,
  }

}
