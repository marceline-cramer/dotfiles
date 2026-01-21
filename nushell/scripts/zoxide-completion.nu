def "nu-complete zoxide path" [context: string] {
  let base_dir = $env.PWD + "/"
  let home = '~' | path expand
  let parts = $context | split row " " | skip 1
  let completions = (^zoxide query --list --exclude $env.PWD -- ...$parts
    | lines
    | str replace $base_dir ""
    | str replace $home "~"
  )

  {
    completions: $completions,
    options: {
      sort: false,
      completion_algorithm: substring,
      case_sensitive: false,
    },
  }
}

def --env --wrapped z [...rest: string@"nu-complete zoxide path"] {
  __zoxide_z ...$rest
}
