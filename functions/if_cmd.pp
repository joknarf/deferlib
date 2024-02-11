function deferlib::if_cmd (
  String         $cmd,
  Any            $value,
  Optional[Hash] $options = {},
) {
  Deferred('deferlib::if_cmd_', [$cmd, $value, $options])
}
