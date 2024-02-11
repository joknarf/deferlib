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
    }),
  }

  notify { 'deferlib::cmd':
    message => deferlib::cmd ({
        'command' => file("${module_name}/myscript"),
    }),
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
  # use deferred command output in env variable
  exec { 'env var deferred':
    command     => 'echo "$myvar"',
    provider    => 'shell',
    environment => [deferlib::cmd({
          'command' => 'echo "myvar=$(cat /tmp/msg)"',
    })],
    logoutput   => true,
  }

  $def_val = deferlib::cmd({ 'command' => 'cat /tmp/msg' })
  notify { 'test string':
    message => Deferred('sprintf', ['myvar=%s', $def_val]),
  }
  notify { 'check':
    message => deferlib::if_file('/tmp/ok', 'file found', 'file not found'),
  }
}
