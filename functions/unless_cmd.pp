function deferlib::unless_cmd (
  $cmd,
  $value,
  $options = {},
)
{
  Deferred('deferlib::unless_cmd_', [$cmd, $value, $options])
}
