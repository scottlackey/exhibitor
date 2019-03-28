# Exhibitor
[![Build Status](https://travis-ci.org/scottlackey/exhibitor.png?branch=master)](https://travis-ci.org/scottlackey/exhibitor)
============

#### Table of Contents

1. [Overview](#overview)
2. [Module Description ](#module-description)
3. [Setup ](#setup)
    * [What exhibitor affects](#what-exhibitor-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with exhibitor](#beginning-with-exhibitor)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Overview

Puppet module for managing/installing exhibitor for Apache zookeeper. Works with Ubuntu 12.04 and 14.04,
possibly other distros.
Uses [Apache Maven](http://maven.apache.org) command line to download the artifacts.

## Module Description

This module includes a POM file for exhibitor and uses it as the configuration for a Maven build resulting
in  a .jar file in the installation directory. The configuration options available in the exhibitor config file 
exhibitor.properties can be passed through from the manifest calling the class.

## Setup
```puppet
class { 'exhibitor':
    servers => ['zk-00-01.domain.com', 'zk-00-02.domain.com'],
  }
```


### What exhibitor affects
```sh
* /etc/default/exhibitor
* /etc/init.d/exhibitor
* $install_dir/exhibitor.properties
* $install_dir/exhibitor-stndalone-${version}.jar
```
### Setup Requirements **OPTIONAL**

exhibitor requires a list of servers, although it will default to 'localhost' for a standalone

### Beginning with exhibitor
```puppet
class { 'exhibitor':
    servers => ['zk-00-01.domain.com', 'zk-00-02.domain.com'],
  }
```

## Usage

Although you may want to modify the defaults for exhibitor.properties, you should set your own preferences for these
```
settings based on your zookeeper installation(s):
exhibitor version $version = '1.5.5',
exhibitor install dir $install_dir = '/opt/exhibitor',
exhibitor conf dir $conf_dir = '/etc/exhibitor',
other exhibitor servers to monitor $servers = ['localhost'],
/etc/default/exhibitor settings $defaultfile_opts = {
    'port'        => '8080',
    'configtype'  => 'file',
    'fsconfigdir' =>  '/opt/exhibitor',
    'hostname'    =>  $::fqdn,
  },
zookeeper settings
$zk_data_dir    = '/mnt/zookeeper/data',
$zk_log_dir     = '/mnt/zookeeper/log',
$zk_install_dir = '/usr/share/zookeeper'
```

## Hostname

By default, the module will set `--hostname` of exhibitor to the node's FQDN. Unfortunately, machine's FQDN might be unresolvable in some cases, and thus it will prevent communication between nodes in the cluster. When that happens, you should see an error such as following in the exhibitor Web GUI

```
Hostname: ip-10-188-205-111.internal
Server Id: 15
Status: java.net.UnknownHostException: ip-10-188-205-111.internal
```

In such case, please consider using the instance's IP address to set as hostname rather than allow the module to use the FQDN by default. This can be done by updating your puppet code where you call the module, or use Hiera. An example of Hiera is shown below:

```YAML
exhibitor::defaultfile_opts:
  hostname: "%{facts.networking.ip}"
```

## Reference

manifests: init.pp install.pp, config.pp, service.pp

## Limitations

only tested on Ubuntu 12.04 and 14.04 so far

## Development

please contribute!

============
