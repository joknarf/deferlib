function deferlib::if_file (
  $file,
  $value,
  $default = undef,
) {
  Deferred('deferlib::if_file_', [$file, $value, $default])
}
