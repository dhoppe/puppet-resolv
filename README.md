# resolv

[![Build Status](https://travis-ci.org/dhoppe/puppet-resolv.png?branch=master)](https://travis-ci.org/dhoppe/puppet-resolv)
[![Code Coverage](https://coveralls.io/repos/github/dhoppe/puppet-resolv/badge.svg?branch=master)](https://coveralls.io/github/dhoppe/puppet-resolv)
[![Puppet Forge](https://img.shields.io/puppetforge/v/dhoppe/resolv.svg)](https://forge.puppetlabs.com/dhoppe/resolv)
[![Puppet Forge - downloads](https://img.shields.io/puppetforge/dt/dhoppe/resolv.svg)](https://forge.puppetlabs.com/dhoppe/resolv)
[![Puppet Forge - endorsement](https://img.shields.io/puppetforge/e/dhoppe/resolv.svg)](https://forge.puppetlabs.com/dhoppe/resolv)
[![Puppet Forge - scores](https://img.shields.io/puppetforge/f/dhoppe/resolv.svg)](https://forge.puppetlabs.com/dhoppe/resolv)

#### Table of Contents

1. [Overview](#overview)
1. [Module Description - What the module does and why it is useful](#module-description)
1. [Setup - The basics of getting started with resolv](#setup)
    * [What resolv affects](#what-resolv-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with resolv](#beginning-with-resolv)
1. [Usage - Configuration options and additional functionality](#usage)
1. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
1. [Limitations - OS compatibility, etc.](#limitations)
1. [Development - Guide for contributing to the module](#development)

## Overview

This module configures the Resolv file.

## Module Description

This module handles configuring Resolv across a range of
operating systems and distributions.

## Setup

### What resolv affects

* resolv configuration file.

### Setup Requirements

* Puppet >= 3.0
* Facter >= 1.6
* [Stdlib module](https://github.com/puppetlabs/puppetlabs-stdlib)

### Beginning with resolv

Install resolv with the default parameters ***(No configuration files will be changed)***.

```puppet
    class { 'resolv': }
```

Install resolv with the recommended parameters.

```puppet
    class { 'resolv':
      config_file_template => 'resolv/common/etc/resolv.conf.erb',
    }
```

## Usage

Update the resolv package.

```puppet
    class { 'resolv':
      package_ensure => 'latest',
    }
```

Remove the resolv package.

```puppet
    class { 'resolv':
      package_ensure => 'absent',
    }
```

Purge the resolv package ***(All configuration files will be removed)***.

```puppet
    class { 'resolv':
      package_ensure => 'purged',
    }
```

Deploy the configuration files from source directory.

```puppet
    class { 'resolv':
      config_dir_source => 'puppet:///modules/resolv/common/etc',
    }
```

Deploy the configuration files from source directory ***(Unmanaged configuration
files will be removed)***.

```puppet
    class { 'resolv':
      config_dir_purge  => true,
      config_dir_source => 'puppet:///modules/resolv/common/etc',
    }
```

Deploy the configuration file from source.

```puppet
    class { 'resolv':
      config_file_source => 'puppet:///modules/resolv/common/etc/resolv.conf',
    }
```

Deploy the configuration file from string.

```puppet
    class { 'resolv':
      config_file_string => '# THIS FILE IS MANAGED BY PUPPET',
    }
```

Deploy the configuration file from template.

```puppet
    class { 'resolv':
      config_file_template => 'resolv/common/etc/resolv.conf.erb',
    }
```

Deploy the configuration file from custom template ***(Additional parameters can
be defined)***.

```puppet
    class { 'resolv':
      config_file_template     => 'resolv/common/etc/resolv.conf.erb',
      config_file_options_hash => {
        'key' => 'value',
      },
    }
```

Deploy additional configuration files from source, string or template.

```puppet
    class { 'resolv':
      config_file_hash => {
        'resolv.2nd.conf' => {
          config_file_path   => '/etc/resolv.2nd.conf',
          config_file_source => 'puppet:///modules/resolv/common/etc/resolv.2nd.conf',
        },
        'resolv.3rd.conf' => {
          config_file_path   => '/etc/resolv.3rd.conf',
          config_file_string => '# THIS FILE IS MANAGED BY PUPPET',
        },
        'resolv.4th.conf' => {
          config_file_path     => '/etc/resolv.4th.conf',
          config_file_template => 'resolv/common/etc/resolv.4th.conf.erb',
        },
      },
    }
```

## Reference

### Classes

#### Public Classes

* resolv: Main class, includes all other classes.

#### Private Classes

* resolv::install: Handles the packages.
* resolv::config: Handles the configuration file.

### Parameters

#### `package_ensure`

Determines if the package should be installed. Valid values are 'present',
'latest', 'absent' and 'purged'. Defaults to 'present'.

#### `package_name`

Determines the name of package to manage. Defaults to 'undef'.

#### `package_list`

Determines if additional packages should be managed. Defaults to 'undef'.

#### `config_dir_ensure`

Determines if the configuration directory should be present. Valid values are
'absent' and 'directory'. Defaults to 'directory'.

#### `config_dir_path`

Determines if the configuration directory should be managed. Defaults to '/etc'

#### `config_dir_purge`

Determines if unmanaged configuration files should be removed. Valid values are
'true' and 'false'. Defaults to 'false'.

#### `config_dir_recurse`

Determines if the configuration directory should be recursively managed. Valid
values are 'true' and 'false'. Defaults to 'true'.

#### `config_dir_source`

Determines the source of a configuration directory. Defaults to 'undef'.

#### `config_file_ensure`

Determines if the configuration file should be present. Valid values are 'absent'
and 'present'. Defaults to 'present'.

#### `config_file_path`

Determines if the configuration file should be managed. Defaults to '/etc/resolv.conf'

#### `config_file_owner`

Determines which user should own the configuration file. Defaults to 'root'.

#### `config_file_group`

Determines which group should own the configuration file. Defaults to 'root'.

#### `config_file_mode`

Determines the desired permissions mode of the configuration file. Defaults to '0644'.

#### `config_file_source`

Determines the source of a configuration file. Defaults to 'undef'.

#### `config_file_string`

Determines the content of a configuration file. Defaults to 'undef'.

#### `config_file_template`

Determines the content of a configuration file. Defaults to 'undef'.

#### `config_file_require`

Determines which package a configuration file depends on. Defaults to 'undef'.

#### `config_file_hash`

Determines which configuration files should be managed via `resolv::define`.
Defaults to '{}'.

#### `config_file_options_hash`

Determines which parameters should be passed to an ERB template. Defaults to '{}'.

#### `domains`

Determines which domains should be searched. Defaults to '["${::domain}"]'.

#### `nameservers`

Determines which nameservers should be queried. Defaults to '['8.8.8.8', '8.8.4.4']'.

#### `options`

Determines which options should be used if more than one nameserver is present.
Defaults to '['timeout:1', 'attempts:1', 'rotate']'.

## Limitations

This module has been tested on:

* Debian 6/7/8
* Ubuntu 12.04/14.04

## Development

### Bug Report

If you find a bug, have trouble following the documentation or have a question
about this module - please create an issue.

### Pull Request

If you are able to patch the bug or add the feature yourself - please make a
pull request.

### Contributors

The list of contributors can be found at: [https://github.com/dhoppe/puppet-resolv/graphs/contributors](https://github.com/dhoppe/puppet-resolv/graphs/contributors)
