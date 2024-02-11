# @author Franck Jouvanceau
# @summary 
#      returns value if deferred shell command execution exit code not 0 else returns options[else]
# @param cmd
#      shell code to execute
# @param value
#      value to return if command exit code is not 0
# @param options
#      shell execution options
# @option options [Any] 'else'
#      returned value if command exit code is 0, default []
# @option options [Variant[String,Integer]] 'user'
#      The user to run the command as
# @option options [Variant[String,Integer]] 'group'
#      The group to run the command as
# @option options [Hash] 'environment'
#      Hash of environment variable names / variable values
# @return [Any]
#      value or options[else]
#
# @example ensure cron service running unless command /bin/ismaintenance returns 0
#      service { 'cron':
#        ensure => deferlib::unless_cmd('/bin/ismaintenance', 'running'),
#      }
#
function deferlib::unless_cmd (
  String         $cmd,
  Any            $value,
  Optional[Hash] $options = {},
) {
  Deferred('deferlib::unless_cmd_', [$cmd, $value, $options])
}
