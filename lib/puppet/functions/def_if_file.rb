#
# returns <value> if file exists
# else returns <default>
# without <default> returns []
# to be called as Deferred type to be run on client
#
# Example:
# service { 'cron':
#    ensure => Deferred('def_if_file', ['/etc/production', 'running']),
# }
#
Puppet::Functions.create_function(:def_if_file) do
  dispatch :def_if_file do
    param 'String', :file
    param 'Any', :value
    optional_param 'Any', :default
  end
  def def_if_file(file, value, default = [])
    if File.exist?(file)
      value
    else
      default
    end
  end
end
