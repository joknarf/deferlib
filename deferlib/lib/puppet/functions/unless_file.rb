# 
# returns value if file does not exists
# to be called as Deferred type to be run on client
#
# Example:
# service { 'cron':
#    ensure => Deferred('unless_file', ['/tmp/maintenance', 'running']),
# }
#
Puppet::Functions.create_function(:unless_file) do
  dispatch :unless_file do
    param 'String', :file
    param 'Any', :value
    optional_param 'Any', :default
  end
  def unless_file(file, value, default = [])
    if File.exists?(file)
    then default
    else value
    end
  end
end
