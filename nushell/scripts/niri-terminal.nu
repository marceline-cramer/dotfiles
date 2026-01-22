# capture current open niri window
let focused_window = niri msg -j focused-window | from json

# detect PWD of focused window
let window_pwd = $focused_window.title
  | parse --regex "^pwd:(?<hostname>.+):(?<pwd>.+)$"
  | into record

# if the current window is another foot window and this isn't disabled from outside, automatically consume
let consume_foot = $env | get --optional CONSUME_FOOT | default 'true'
if $focused_window.app_id == "footclient" and $consume_foot == 'true' {
  niri msg action consume-window-into-column
}

# Find this shell's window (window with highest ID)
let newest_window = niri msg -j windows | from json | sort-by id | last 1 | into record

# focus this window
# Niri disables focusing of new foot windows to permit querying current window
niri msg action focus-window --id $newest_window.id

# if no window is selected, just enter prompt
if ($window_pwd | is-empty) {
  return
}

# attempt SSH if remote hostname
if $window_pwd.hostname != (hostname) {
  ssh -t $"($window_pwd.hostname).local" $"cd ($window_pwd.pwd); nu -l"
  exit
}

# otherwise, enter PWD and start prompt
cd $window_pwd.pwd
