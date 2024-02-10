# @summary Samples/Test deferred functions
#
# Example of deferlib functions
#
# @example
#   include deferlib::test
#
class deferlib::test {
  $a = Deferred('regexpescape', ['a+b'])

  notify { 'deferred':
    message => $a,
  }

  service { 'cron':
    #ensure => Deferred('unless_file', ['/tmp/maintenance', 'running']),
    #ensure => Deferred('onlyif_file', ['/tmp/production', 'running']),
    #ensure => Deferred('onlyif_cmd', ['false', 'running']),
    #ensure => Deferred('agent_cmd', ['[ -f /tmp/flag ] || echo running']),
    #ensure => Deferred('agent_cmd', ['cat /tmp/cron_local_ensure', 'running']),
    ensure => 'running',
    noop   => Deferred('unless_file', ['/tmp/flag', false, true]),
  }
}
