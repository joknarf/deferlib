# @author Franck Jouvanceau
# @summary 
#      returns value if file does not exist else returns default
# @param file [String]
#      path to file to check existence
# @param value
#      value to return if file does not exist
# @param default
#      value to return if file exists (default: [])
#
# @return [Any]
#
# @example ensure service cron is running unless file /etc/maintenance exists
#      service { 'cron':
#        ensure => deferlib::unless_file('/etc/maintenance', 'running')
#      }
#
function deferlib::unless_file (
  String $file,
  Any    $value,
  Any    $default = undef,
) {
  Deferred('deferlib::unless_file_', [$file, $value, $default])
}
