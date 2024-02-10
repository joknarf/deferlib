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
```ruby
onlyif_cmd(<shell_command>, <value_exit_not_0>, [<value_if_exit_0])
unless_cmd(<shell_command>, <value_exit_not_0>, [<value_if_exit_0])

onlyif_file(<file_path>, <value_file_exists>, [<value_if_file_not_exists])
unless_file(<file_path>, <value_file_not_exists>, [<value_if_file_exists])

agent_exec({
  command     => <shell_command>,
  default     => <value_if_empty_output>,
  user        => <user_running_command>,
  environment => { <variable> => <value>, ... }
})
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
          'command' => 'cat /etc/cron_ensure'
          'default' => 'running'
  }]),
}
```

