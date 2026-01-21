# if not running in foot, don't do any window manipulation
if $env.TERM != "foot" {
  return
}

# if overridden, don't do any window manipulation
if ($env | get -o NESTED_FOOT | default false) != false {
  return
}

# keep child interactive sessions from nesting
$env.NESTED_FOOT = true

# capture current open niri window
let focused_window = niri msg -j focused-window | from json

# attempt to change PWD to window title
let window_pwd = $focused_window.title
  | parse --regex "^pwd:(?<pwd>.+)$"
  | into record
  | default "" pwd

if $window_pwd != "" {
  cd $window_pwd.pwd
}

# Find this shell's window (window with highest ID)
let newest_window = niri msg -j windows | from json | sort-by id | last 1 | into record

# If the current window is another foot window and this isn't disabled from outside, automatically consume
let consume_foot = $env | get --optional CONSUME_FOOT | default 'true'
if $focused_window.app_id == "footclient" and $consume_foot == 'true' {
  niri msg action consume-window-into-column
}

# Focus this window
# Niri disables focusing of new foot windows to permit querying current window
niri msg action focus-window --id $newest_window.id
