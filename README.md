# sc_nginx

#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with sc_redis](#setup)
    * [What sc_nginx affects](#what-sc_nginx-affects)
    * [Beginning with sc_redis](#beginning-with-sc_redis)
4. [Usage - Configuration options and additional functionality](#usage)

## Overview

ScaleCommerce Wrapper Module for puppet-nginx module. Manages Supervisord.

## Module Description

This module uses hiera to configure supervisord config for nginx.

## Setup

### What sc_nginx affects

* nginx
* supervisord


### Beginning with sc_nginx

You will need a working hiera-Setup (https://docs.puppetlabs.com/hiera/3.1/complete_example.html).

Check out our solultion for Puppet-Hiera-Roles (https://github.com/ScaleCommerce/puppet-hiera-roles).

## Usage:

Put this into your node.yaml or role.yaml.

``` 
---
classes:
  - sc_nginx
  
```

