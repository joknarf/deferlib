function deferlib::unless_file (
  $file,
  $value,
  $default = undef,
) {
  Deferred('deferlib::unless_file_', [$file, $value, $default])
}
