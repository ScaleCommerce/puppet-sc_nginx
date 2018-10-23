[![build status](https://gitlab.scale.sc/sc-puppet/puppet-sc_nginx/badges/master/build.svg)](https://gitlab.scale.sc/sc-puppet/puppet-sc_nginx/commits/master)
# sc_nginx

#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with sc_nginx](#setup)
    * [What sc_nginx affects](#what-sc_nginx-affects)
    * [Beginning with sc_nginx](#beginning-with-sc_redis)
4. [Usage - Configuration options and additional functionality](#usage)
4. [Testing with InSpec](#testing)

## Overview

ScaleCommerce Wrapper Module for puppet-nginx module. Manages Supervisord.

## Module Description

This module uses hiera to configure supervisord and nginx. We're using upstream modules [voxpupuli/puppet-nginx](https://github.com/voxpupuli/puppet-nginx) and [ajcrowe/puppet-supervisord](https://github.com/ajcrowe/puppet-supervisord). This module is compatible with Ubuntu 14.04, Ubuntu 16.04, Puppet 3, Puppet 4, Puppet 5.

## Setup

### What sc_nginx affects

* nginx
* supervisord

### Beginning with sc_nginx

You will need a working hiera-Setup (https://docs.puppetlabs.com/hiera/3.1/complete_example.html).

Check out our solultion for Puppet-Hiera-Roles (https://github.com/ScaleCommerce/puppet-hiera-roles).

## Usage

Put this into your node.yaml or role.yaml. This module supports merging of configuration (i.e. vhosts) from all hierarchy levels. The upstream module `voxpupuli/puppet-nginx` currently uses automatic parameter lookup, which doesn't support that  (https://github.com/voxpupuli/puppet-nginx/issues/614, https://docs.puppet.com/hiera/3.3/puppet.html#automatic-parameter-lookup).

```
---
classes:
  - sc_nginx

```

Check out hiera config examples in [test/hiera/module.yaml.puppet-nginx](test/hiera/module.yaml.puppet-nginx)

## Testing

When making changes you can test this module locally with [gitlab-runner on Mac OSX](https://docs.gitlab.com/runner/install/osx.html)

``gitlab-runner exec docker --env "GIT_STRATEGY=none" --docker-volumes `pwd`:/builds/project-0 xenial:puppet5``
