function deferlib::unless_file (
  String $file,
  Any    $value,
  Any    $default = undef,
) {
  Deferred('deferlib::unless_file_', [$file, $value, $default])
}
