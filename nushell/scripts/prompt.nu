# taken from: https://github.com/nushell/nushell/blob/main/crates/nu-utils/src/default_files/default_env.nu
let dir = match (do -i { $env.PWD | path relative-to $nu.home-dir }) {
  null => $env.PWD
  '' => '~'
  $relative_pwd => ([~ $relative_pwd] | path join)
}

# set window title to PWD
let window_title = $"(ansi title)pwd:($env.PWD)(ansi st)"

let repo = gstat

let branch = match $repo.branch {
  "no_branch" => ""
  $branch => $' [($branch)]'
}

mut git_notes = []

# these repeat functions could probably be encapsulated in a closure
match $repo.ahead {
  -1 | 0 => []
  $ahead => {
    $git_notes = ($git_notes | append $'ahead ($ahead) commits')
  }
}

match $repo.behind {
  -1 | 0 => []
  $behind => {
    $git_notes = ($git_notes | append $'behind ($behind) commits')
  }
}

let git_notes = match ($git_notes | str join ", ") {
  "" => ""
  $joined => $' <($joined)>'
}

$'($window_title)(ansi purple_bold)(hostname)(ansi rst_bo) ⇐ (ansi green_bold)($dir)(ansi purple)($branch)(ansi red)($git_notes)'
