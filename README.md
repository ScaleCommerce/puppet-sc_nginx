# sc_nginx

#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with sc_redis](#setup)
    * [What sc_nginx affects](#what-sc_nginx-affects)
    * [Beginning with sc_redis](#beginning-with-sc_redis)
4. [Usage - Configuration options and additional functionality](#usage)
4. [Testing with InSpec](#testing)

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

## Usage

Put this into your node.yaml or role.yaml.

``` 
---
classes:
  - sc_nginx
  
```

## Testing

GitLab runner is activated to test after each push.

### InSpec

Configuration testing is done with `InSpec`: https://www.inspec.io/

### Local testing

To test changes before committing them, you can execute the gitlab runner locally.
Unfortunately the official gitlab-runner does not support local testing (according feature request: https://gitlab.com/gitlab-org/gitlab-ci-multi-runner/issues/1359). So we need a custom binary:

1. install docker

1. download gitlab-runner binary

```bash
sudo curl --output /usr/local/bin/gitlab-ci-multi-runner-sc https://gitlab.scale.sc/a.kirchner/gitlab-ci-multi-runner-sc/raw/master/bin/gitlab-ci-multi-runner-sc
sudo chmod +x /usr/local/bin/gitlab-ci-multi-runner-sc
```

1. execute in your working copy

```bash
# jfryman-nginx
gitlab-ci-multi-runner-sc exec docker --docker-volumes `pwd`:/tmp/local-working-directory test:jfryman-nginx:ubuntu-14.04

# puppet-nginx
gitlab-ci-multi-runner-sc exec docker --docker-volumes `pwd`:/tmp/local-working-directory test:puppet-nginx:ubuntu-14.04
```