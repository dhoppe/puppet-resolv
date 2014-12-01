# == Class: resolv::config
#
class resolv::config {
  if $::resolv::config_dir_source {
    file { 'resolv.dir':
      ensure  => $::resolv::config_dir_ensure,
      path    => $::resolv::config_dir_path,
      force   => $::resolv::config_dir_purge,
      purge   => $::resolv::config_dir_purge,
      recurse => $::resolv::config_dir_recurse,
      source  => $::resolv::config_dir_source,
      require => $::resolv::config_file_require,
    }
  }

  if $::resolv::config_file_path {
    file { 'resolv.conf':
      ensure  => $::resolv::config_file_ensure,
      path    => $::resolv::config_file_path,
      owner   => $::resolv::config_file_owner,
      group   => $::resolv::config_file_group,
      mode    => $::resolv::config_file_mode,
      source  => $::resolv::config_file_source,
      content => $::resolv::config_file_content,
      require => $::resolv::config_file_require,
    }
  }
}
