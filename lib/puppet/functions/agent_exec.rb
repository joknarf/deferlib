#
# returns <command> output
# if <command> output is empty returns <default>
# if <default> not passed, <default> is []
# to be called as Deferred type to be run on client
# to be used on resource parameter value
#
# Example:
# service { 'cron':
#   ensure => Deferred('agent_exec', [{
#         command     => 'cat /etc/cron_local_ensure',
#         default     => 'running',
#         user        => 'foo',
#         environment => {'PATH' => '/bin:/usr/bin'},
#   }]),
# }
#
Puppet::Functions.create_function(:agent_exec) do
  dispatch :agent_exec do
    param 'Hash', :options
  end

  def agent_exec(options = {})
    default = []
    default = options['default'] if options.key?('default')
    unless options.key?('command')
      return default
    end
    cmd = options['command']
    opts = {}
    opts[:uid] = options['user'] if options.key?('user')
    opts[:gid] = options['group'] if options.key?('group')
    opts[:environment] = options['environment'] if options.key?('environment')
    result = Puppet::Util::Execution.execute(cmd, opts)
    out = result.to_s.chomp
    if out == '' or result.exitstatus != 0
      default
    else
      out
    end
  end
end
