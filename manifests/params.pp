# == Class: resolv::params
#
class resolv::params {
  $package_name = $::osfamily ? {
    default => undef,
  }

  $package_list = $::osfamily ? {
    default => undef,
  }

  $config_dir_path = $::osfamily ? {
    default => '/etc',
  }

  $config_file_path = $::osfamily ? {
    default => '/etc/resolv.conf',
  }

  $config_file_owner = $::osfamily ? {
    default => 'root',
  }

  $config_file_group = $::osfamily ? {
    default => 'root',
  }

  $config_file_mode = $::osfamily ? {
    default => '0644',
  }

  $config_file_require = $::osfamily ? {
    default => undef,
  }

  case $::osfamily {
    'Debian', 'Gentoo', 'Archlinux', 'RedHat', 'FreeBSD': {
    }
    default: {
      fail("${::operatingsystem} not supported.")
    }
  }
}
