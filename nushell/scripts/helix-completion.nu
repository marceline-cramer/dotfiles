def "nu-complete hx path" [context: string] {
  let gstat = gstat
  if $gstat.state == "no_state" {
    return
  }

  let completions = (git ls-files | lines)

  {
    completions: $completions,
    options: {
      sort: false,
      completion_algorithm: fuzzy,
      case_sensitive: false,
    },
  }
}

def --env --wrapped hx [...rest: string@"nu-complete hx path"] {
  helix ...$rest
}
