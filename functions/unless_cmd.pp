function deferlib::unless_cmd (
  String         $cmd,
  Any            $value,
  Optional[Hash] $options = {},
) {
  Deferred('deferlib::unless_cmd_', [$cmd, $value, $options])
}
