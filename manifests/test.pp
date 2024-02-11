# @summary Samples/Test deferred functions
#
# Example of deferlib functions
#
# @example
#   include deferlib::test
#
class deferlib::test {
  notify { 'deferred':
    message => Deferred('agent_exec', [{
          'command'     => 'cat /tmp/message;id',
          'else'        => 'no message',
          'user'        => 'joknarf',
          'environment' => { 'PATH' => '/bin:/sbin' },
    }]),
  }

  service { 'cron':
    #ensure => Deferred('unless_file', ['/tmp/maintenance', 'running']),
    #ensure => Deferred('onlyif_file', ['/tmp/production', 'running']),
    #ensure => Deferred('onlyif_cmd', ['false', 'running']),
    #ensure => Deferred('agent_exec', [{
    #         command => 'cat /tmp/cron_local_ensure',
    #         else    => 'running',
    #}]),
    ensure => 'running',
    noop   => Deferred('unless_file', ['/tmp/flag', false, true]),
  }
}
