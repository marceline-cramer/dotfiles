# You can pretty-print and page through the documentation for configuration
# options using:
#     config nu --doc | nu-highlight | less -R

alias hx = helix

source scripts/carapace.nu
source scripts/helix-completion.nu
source scripts/zoxide.nu
source scripts/zoxide-completion.nu

source secrets.nu

$env.config.shell_integration.osc2 = false # use custom window title
$env.config.shell_integration.osc9_9 = true # terminal pwd
$env.config.use_kitty_protocol = true # control-backspace and such
$env.config.buffer_editor = "hx"
$env.config.table.mode = "compact"
$env.config.show_banner = false

# Scripts
export def --env niri-fzf [] {
  source scripts/niri-fzf.nu
}

export def --env niri-terminal [] {
  source scripts/niri-terminal.nu
}

$env.PAGER = "less"
$env.LESS = "--mouse --wheel-lines=5 -R"
$env.GOBIN = "/home/mars/.local/bin"

$env.PATH = [
  /home/mars/.local/share/fnm/node-versions/v22.13.1/installation/bin
  /home/mars/.cargo/bin
  /home/mars/.local/bin
  ...$env.PATH
]

$env.PROMPT_COMMAND_RIGHT = ""
$env.PROMPT_INDICATOR = " <?> "
$env.PROMPT_COMMAND = {|| source scripts/prompt.nu }
