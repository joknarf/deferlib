#
# returns <value> if command returns 0
# else returns <default>
# without <default>, returns []
#
# to be called as Deferred type to be run on client
# to be used on resource parameter value
# Example:
# service { 'cron':
#    ensure => Deferred('onlyif_cmd', ['! grep maintenance /tmp/status', 'running',{
#          'else'  => 'stopped'
#          'user'  => 'foo',
#          'group' => 'bar',
#          'environment' => {'SECRET' => 'mysec'},
#    }]),
# }
#
Puppet::Functions.create_function(:onlyif_cmd) do
  dispatch :onlyif_cmd do
    param 'String', :cmd
    param 'Any', :value
    optional_param 'Hash', :options
  end

  def onlyif_cmd(cmd, value, options = {})
    default = []
    default = options['else'] if options.key?('else')
    opts = {}
    opts[:uid] = options['user'] if options.key?('user')
    opts[:gid] = options['group'] if options.key?('group')
    opts[:environment] = options['environment'] if options.key?('environment')
    result = Puppet::Util::Execution.execute(cmd, opts)
    if result.exitstatus == 0
      value
    else
      default
    end
  end
end
