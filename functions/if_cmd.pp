# @author Franck Jouvanceau
# @summary 
#      returns value if deferred shell command execution exit code 0 else returns options[else]
# @param cmd
#      shell code to execute
# @param value
#      value to return if command exit code is 0
# @param options
#      shell execution options
# @option options [Any] :else
#      returned value if command exit code not 0, default []
# @option options [Variant[String,Integer]] :user
#      The user to run the command as
# @option options [Variant[String,Integer]] :group
#      The group to run the command as
# @option options [Hash] :environment
#      Hash of environment variable names / variable values
# @return [Any]
#      value or options[else]
#
# @example if command /bin/ismaintenance ensure cron service stopped else ensure running 
#      service { 'cron':
#        ensure => deferlib::if_cmd('/bin/ismaintenance', 'stopped', {
#          else        => 'running',
#          user        => 'foo',
#          group       => 'bar',
#          environment => { 'myvar' => 'myvalue' },
#        }),
#      }
#
function deferlib::if_cmd (
  String         $cmd,
  Any            $value,
  Optional[Hash] $options = {},
) {
  Deferred('deferlib::if_cmd_', [$cmd, $value, $options])
}
