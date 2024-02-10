#
# returns <value> if command returns 0
# else returns <default>
# without <default>, returns []
#
# to be called as Deferred type to be run on client
# to be used on resource parameter value
# Example:
# service { 'cron':
#    ensure => Deferred('onlyif_cmd', ['! grep maintenance /tmp/status', 'running']),
# }
#
Puppet::Functions.create_function(:onlyif_cmd) do
  dispatch :onlyif_cmd do
    param 'String', :cmd
    param 'Any', :value
    optional_param 'Any', :default
  end
  def onlyif_cmd(cmd, value, default = [])
    if system(cmd)
      value
    else
      default
    end
  end
end
