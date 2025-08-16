$env.config.history.file_format = "sqlite"
$env.config.history.max_size = 5_000_000
$env.config.history.isolation = true
$env.config.show_banner = false
$env.config.edit_mode = "vi"
$env.config.buffer_editor = "code"
$env.config.footer_mode = "auto"
$env.config.datetime_format.normal = "%Y-%m-%d %H:%M:%S"
$env.config.color_config = (vs-code-dark-plus)

$env.HOSTNAME = (sys host).hostname | str replace --regex "[.].*" ""
$env.PROMPT_COMMAND = {||
    let path = match (do -i { $env.PWD | path relative-to $nu.home-path }) {
        null => $env.PWD
        "" => "~"
        $rel => ([~ $rel] | path join)
    }

    let separator_color = (ansi yellow_bold)
    let path_color = $"(ansi reset)(ansi yellow)"
    let colorized_path_sep = $"($separator_color)(char path_sep)($path_color)"
    let colorized_path = $path | str replace --all (char path_sep) $colorized_path_sep

    [
        $"(ansi bg_light_cyan)(ansi black_bold) ($env.HOSTNAME) (ansi reset)"
        $"($path_color) ($colorized_path) "
    ] | str join
}

$env.PROMPT_COMMAND_RIGHT = {||
    let last_exit_segment = if $env.LAST_EXIT_CODE != 0 {
        $"(ansi bg_red) ($env.LAST_EXIT_CODE) (ansi reset) "
    } else { "" }

    let time_color = $"(ansi reset)(ansi dark_gray_bold)"
    # let time_color = $"(ansi reset)(ansi default)"
    let time_sep_color = (ansi dark_gray_dimmed)
    let time_colorized = (
        date now |
        format date "%Y-%m-%d %H:%M:%S" |
        str replace --all --regex "([-:])" $"($time_sep_color)${1}($time_color)"
    )
    let time_segment = $"(ansi reset)($time_color)($time_colorized)"

    $"($last_exit_segment)($time_segment)"
}

$env.PROMPT_INDICATOR_VI_INSERT = "\u{276f} "
$env.PROMPT_INDICATOR_VI_NORMAL = "\u{eb04} "
