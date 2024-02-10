# 
# returns value if file does not exists
# to be called as Deferred type to be run on client
#
# Example:
# service { 'cron':
#    ensure => Deferred('unless_cmd', ['grep maintenance /tmp/status', 'running']),
# }
#
Puppet::Functions.create_function(:unless_cmd) do
  dispatch :unless_cmd do
    param 'String', :cmd
    param 'Any', :value
    optional_param 'Any', :default
  end
  def unless_cmd(cmd, value, default = [])
    if system(cmd)
    then default
    else value
    end
  end
end
