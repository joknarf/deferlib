# @author Franck Jouvanceau
# @summary 
#      returns output of deferred shell command execution
#      or options[else] if commmand exit code not 0
# @param options [Hash]
#      options of shell execution
# @option options [String] 'command'
#      shell command to execute
# @option options [Any] 'else'
#      returned value if command exit code not 0
# @option options [Variant[String,Integer]] 'user'
#      The user to run the command as
# @option options [Variant[String,Integer]] 'group'
#      The group to run the command as
# @option options [Hash] 'environment'
#      Hash of environment variable names / variable values
# @return [Any]
#      output of command or options[else]
#
# @example ensure cron from file content on agent side
#      service { 'cron':
#        ensure => deferlib::cmd({
#          'command'     => 'cat /etc/cron_ensure',
#          'else'        => 'running',
#          'user'        => 'foo',
#          'group'       => 'bar',
#          'environment' => { 'myvar' => 'myvalue' },
#        }),
#      }
#
function deferlib::cmd (
  Hash $options,
) {
  Deferred('deferlib::cmd_', [$options])
}
