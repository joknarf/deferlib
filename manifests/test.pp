# @summary Samples/Test deferred functions
#
# Example of deferlib functions
#
# @example
#   include deferlib::test
#
class deferlib::test {
  notify { 'deferred':
    message => deferlib::cmd({
        'command'     => 'cat /tmp/message;id',
        'else'        => 'no message',
        'user'        => 'joknarf',
        'environment' => { 'PATH' => '/bin:/sbin' },
    }),
  }

  notify { 'script from module':
    message => deferlib::cmd({
        'command' => file("${module_name}/myscript"),
        'match'   => '^(hello|yop)$',
        'else'    => 'bad output',
    }),
  }

  notify { 'deferlib::if_cmd':
    message => deferlib::if_cmd(file("${module_name}/myscript"), 'exit ok'),
  }

  service { 'cron':
    #ensure => deferlib::unless_file('/tmp/maintenance', 'running'),
    #ensure => deferlib::if_file('/tmp/production', 'running'),
    #ensure => deferlib::if_cmd('false', 'running'),
    #ensure => deferlib::cmd({
    #         command => 'cat /tmp/cron_local_ensure',
    #         else    => 'running',
    #}),
    ensure => 'running',
    noop   => deferlib::if_file('/tmp/flag', true, false),
    #noop   =>deferlib::unless_file('/tmp/flag', false, true),
  }

  $def_val = deferlib::cmd({ 'command' => 'python3 --version' })
  notify { 'test deferred concat string':
    message => Deferred('sprintf', ['%s: %s', 'python package', $def_val]),
  }

  notify { 'check':
    message => deferlib::if_file('/tmp/ok', 'file found', 'file not found'),
  }
}
