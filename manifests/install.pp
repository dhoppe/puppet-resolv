# == Class: resolv::install
#
class resolv::install {
  if $::resolv::package_name {
    package { 'resolv':
      ensure => $::resolv::package_ensure,
      name   => $::resolv::package_name,
    }
  }

  if $::resolv::package_list {
    ensure_resource('package', $::resolv::package_list, { 'ensure' => $::resolv::package_ensure })
  }
}
