# @author Franck Jouvanceau
# @summary 
#      returns value if file exists else returns default
# @param file [String]
#      path to file to check existence
# @param value
#      value to return if file exists
# @param default
#      value to return if file does not exist (default: [])
#
# @return [Any]
#
# @example ensure service cron is stopped if file /etc/maintenance exists, else ensure running
#      service { 'cron':
#        ensure => deferlib::if_file('/etc/maintenance', 'stopped', 'running')
#      }
#
function deferlib::if_file (
  String $file,
  Any    $value,
  Any    $default = undef,
) {
  Deferred('deferlib::if_file_', [$file, $value, $default])
}
