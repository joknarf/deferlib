#
# returns value if file does not exist
# to be called as Deferred type to be run on client
#
# Example:
# service { 'cron':
#    ensure => Deferred('def_unless_file', ['/tmp/maintenance', 'running']),
# }
#
Puppet::Functions.create_function(:def_unless_file) do
  dispatch :def_unless_file do
    param 'String', :file
    param 'Any', :value
    optional_param 'Any', :default
  end
  def def_unless_file(file, value, default = [])
    if File.exist?(file)
      default
    else
      value
    end
  end
end
