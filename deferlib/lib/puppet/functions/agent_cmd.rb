# 
# returns <cmd> output
# if <cmd> output is '' return default 
# if <default> not passed, <default> is []
# to be called as Deferred type to be run on client
# to be used on resource parameter value
# Example:
# service { 'cron':
#    ensure => Deferred('agent_cmd', ['cat /etc/cron_local_ensure', 'running']),
# }
#
Puppet::Functions.create_function(:agent_cmd) do
  dispatch :agent_cmd do
    param 'String', :cmd
    optional_param 'Any', :default
  end
  def agent_cmd(cmd, default = [])
    out = %x{#{cmd}}
    if out == ''
    then default
    else out.chomp
    end
  end
end
