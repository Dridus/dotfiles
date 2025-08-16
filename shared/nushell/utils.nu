def topdu [top?: path] {
    ls ($top | default .)
        | where type == "dir"
        | par-each { ||
            let dir = $in;
            $dir
                | update size (
                    ls ($dir.name | path join "**/*" | into glob)
                        | reduce --fold 0 {|i,a| ($i.size | into int) + $a }
                        | into filesize
                )
        }
        | sort-by size
}

def parsejournaltext [
    path?: path
    --encoding: string = "utf-8"
]: [
    list -> list
    nothing -> list
] {
    let input = if $path == null { $in } else { open $path | decode $encoding | lines };
    $input
        | parse --regex '^(?P<timestamp>\S+) (?P<host>\S+) (?P<process>.+?)\[(?P<pid>\d+)\]: \[(?P<level>[^] ]+)\s*\] (?P<code>\S+) (?P<content>.*)$'
        | enumerate
        | flatten
        | update pid { into int }
        | update content { from json }
}
