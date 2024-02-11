function deferlib::if_cmd(
  $cmd,
  $value,
  $options = {},
)
{
  Deferred('deferlib::if_cmd_', [$cmd, $value, $options])
}
