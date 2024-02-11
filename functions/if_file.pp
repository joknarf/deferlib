function deferlib::if_file (
  String $file,
  Any    $value,
  Any    $default = undef,
) {
  Deferred('deferlib::if_file_', [$file, $value, $default])
}
