# deferlib

## Table of Contents

1. [Description](#description)
1. [Setup - The basics of getting started with deferlib](#setup)
    * [What deferlib affects](#what-deferlib-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with deferlib](#beginning-with-deferlib)
1. [Usage - Configuration options and additional functionality](#usage)

## Description

Control your resources parameters from client side without creating useless facts.

Provides functions library to use to get values for resource parameters
from files/command executed on agent side (deferred), providing way to control resources
from agent host local things without creating facts that executes on all servers.
These function are to declare as Deferred type to be executed on agent side.

## Setup

### Setup Requirements

Puppet agent/server >= 7

### Beginning with deferlib

deferlib provides functions to use to modify resource parameters from host runnning
puppet agent (instead of using facts for example).

Example:
```puppet
# do not restart cron when maintenance flag file exists putting ensure to undef
# => function to read: unless file /etc/maintenance exists ensure running, (else ensure undef)
service { 'cron':
  ensure => Deffered('unless_file', ['/etc/maintenance', 'running']),
}
```

## Usage

functions available:

* onlyif_file()
```ruby
onlyif_file(file, value, [default])
```
parameters:
```
file    : path to file to check existence
value   : value returned if file exists
default : value returned if file does not exist (default [])
```

* unless_file()
```ruby
unless_file(file, value, [default])
```
parameters:
```
file    : path to file to check existence
value   : value returned if file does not exist
default : value returned if file exists (default [])
```

* onlyif_cmd()
```ruby
onlyif_cmd(cmd, value, [<options>])
Description:
returns `value` if exit code of `cmd` is 0 else returns `options['else']` (default to [])
```
Parameters:
```
cmd     : shell code to execute
value   : value returned if exit status is 0
options : {
  'else'        => # value returned if exit status is not 0 (default: [])
  'user'        => # The user to run the command as	
  'group'       => # The group to run the command as
  'environment' => # A Hash of environment variables
}
options['environment'] : {
  '<variable name>' => # value of the environement variable
  ...
}
```
* unless_cmd()
```ruby
unless_cmd(cmd, value, [<options>])
```
parameters:
```
cmd     : shell code to execute
value   : value returned if exit status is not 0
options : Hash with optional settings
options : {
  'else'        => # value returned if exit status is 0 (default: [])
  'user'        => # The user to run the command as	
  'group'       => # The group to run the command as
  'environment' => # A Hash of environment variables
}
options['environment'] : {
  '<variable name>' => # value of the environement variable
  ...
}
```

* agent_exec()
```ruby
agent_exec(options)
```
parameters:
```
options : Hash with parameters
options : {
  'command'     => # Shell code to execute
  'else'        => # value returned if exit code is not 0
  'user'        => # The user to run the command as	
  'group'       => # The group to run the command as
  'environment' => # A Hash of environment variables
})
options['environment'] : {
  '<variable name>' => # value of the environement variable
  ...
}
```

Examples:
```
# do not restart cron when maintance flag file exists putting noop to true
service { 'cron':
  ensure => 'running',
  noop   => Deffered('unless_file',['/etc/maintenance', false, true]),
}

# force ensure from local file content if exists, else ensure running
service { 'cron':
  ensure => Deferred('agent_exec',[{
          'command' => 'cat /etc/cron_ensure',
          'else'    => 'running'
  }]),
}
```

