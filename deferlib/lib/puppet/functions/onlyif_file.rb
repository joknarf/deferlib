# 
# returns <value> if file exists
# else returns <default>
# without <default> returns []
# to be called as Deferred type to be run on client
#
# Example:
# service { 'cron':
#    ensure => Deferred('onlyif_file', ['/etc/production', 'running']),
# }
#
Puppet::Functions.create_function(:onlyif_file) do
  dispatch :onlyif_file do
    param 'String', :file
    param 'Any', :value
    optional_param 'Any', :default
  end
  def onlyif_file(file, value, default = [])
    if File.exists?(file)
    then value
    else default
    end
  end
end
