#
# returns <command> output
# if <command> exit code <> 0 returns <else>
# <else> default is []
# to be called as Deferred type to be run on client
# to be used on resource parameter value
#
# Example:
# service { 'cron':
#   ensure => Deferred('def_exec', [{
#         command     => 'cat /etc/cron_local_ensure',
#         else        => 'running',
#         user        => 'foo',
#         environment => {'PATH' => '/bin:/usr/bin'},
#   }]),
# }
#
Puppet::Functions.create_function(:def_exec) do
  dispatch :def_exec do
    param 'Hash', :options
  end

  def def_exec(options = {})
    default = []
    default = options['else'] if options.key?('else')
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
    if result.exitstatus != 0
      default
    else
      out
    end
  end
end
