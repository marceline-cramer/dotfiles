let current_windows = niri msg -j windows | from json

let icon_override = {
  'footclient': 'utilities-terminal',
  'cursor': 'co.anysphere.cursor',
}

let dmenu_input = $current_windows
  | insert icon {|it| $icon_override | get -o $it.app_id | default $it.app_id }
  | each {|it| $"($it.id)\t($it.title)\u{0}icon\u{1f}($it.icon)\n"}
  | str join

print $dmenu_input

let fuzzel_output = $dmenu_input | (fuzzel -d --with-nth 2 --accept-nth 1 --auto-select)

if $fuzzel_output == "" {
  return;
}

niri msg action focus-window --id $fuzzel_output
