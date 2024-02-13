#
# returns <command> output
# if <command> exit code <> 0 returns <else>
# <else> default is []
# to be called as Deferred type to be run on client
# to be used on resource parameter value
#
# Example:
# service { 'cron':
#   ensure => Deferred('deferlib::cmd_', [{
#         'command'     => 'cat /etc/cron_local_ensure',
#         'match'       => '^(running|stopped)$',
#         'else'        => 'running',
#         'user'        => 'foo',
#         'environment' => {'PATH' => '/bin:/usr/bin'},
#   }]),
# }
#
Puppet::Functions.create_function(:'deferlib::cmd_') do
  dispatch :cmd do
    param 'Hash', :options
  end

  def cmd(options = {})
    default = []
    default = options['else'] if options.key?('else')
    unless options.key?('command')
      return default
    end
    command = options['command']
    opts = {}
    opts[:uid] = options['user'] if options.key?('user')
    opts[:gid] = options['group'] if options.key?('group')
    opts[:environment] = options['environment'] if options.key?('environment')
    result = Puppet::Util::Execution.execute(command, opts)
    out = result.to_s.chomp
    if result.exitstatus != 0
      return default
    end
    if options.key?('match')
      if out.match(options['match'])
        return out
      end
      return default
    end
    out
  end
end
