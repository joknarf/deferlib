# @summary Samples/Test deferred functions
#
# Example of deferlib functions
#
# @example
#   include deferlib::test
#
class deferlib::test {
  notify { 'deferred':
    message => Deferred('def_cmd', [{
          'command'     => 'cat /tmp/message;id',
          'else'        => 'no message',
          'user'        => 'joknarf',
          'environment' => { 'PATH' => '/bin:/sbin' },
    }]),
  }

  notify { 'script from module':
    message => Deferred('def_cmd', [{
          'command' => file("${module_name}/myscript"),
    }]),
  }

  notify { 'deferlib:cmd':
    message => Deferred('deferlib::cmd', [{
          'command' => file("${module_name}/myscript"),
    }]),
  }

  service { 'cron':
    #ensure => Deferred('def_unless_file', ['/tmp/maintenance', 'running']),
    #ensure => Deferred('def_if_file', ['/tmp/production', 'running']),
    #ensure => Deferred('def_if_cmd', ['false', 'running']),
    #ensure => Deferred('def_cmd', [{
    #         command => 'cat /tmp/cron_local_ensure',
    #         else    => 'running',
    #}]),
    ensure => 'running',
    noop   => Deferred('deferlib::unless_file', ['/tmp/flag', false, true]),
  }
}
