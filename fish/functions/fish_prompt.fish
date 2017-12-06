function fish_prompt --description 'Write out the prompt'
    set -l cmd_status $status
    set -l duration $CMD_DURATION

    set -l duration_days (math "$duration / 86400000")
    set -l duration_days_text

    if [ $duration_days -gt 0 ]
        set duration_days_text "$duration_days d"
    end

    set -l duration_hours (math "($duration / 3600000) % 24")
    set -l duration_hours_text

    if [ $duration_hours -gt 0 ]
        set duration_hours_text "$duration_hours h"
    end

    set -l duration_minutes (math "($duration / 60000) % 60")
    set -l duration_minutes_text

    if [ $duration_minutes -gt 0 ]
        set duration_minutes_text "$duration_minutes m"
    end

    set -l duration_seconds (math "($duration / 1000) % 60")
    set -l duration_seconds_text

    if [ $duration_seconds -gt 0 ]
        set duration_seconds_text "$duration_seconds s"
    end

    set -l duration_milliseconds (math "$duration % 1000")
    set -l duration_milliseconds_text

    if [ '(' $duration_milliseconds -gt 0 ')' -o '(' $duration -eq 0 ')' ]
        set duration_milliseconds_text "$duration_milliseconds ms"
    end

    set -l cmd_duration (string join ' ' $duration_days_text \
                                         $duration_hours_text \
                                         $duration_minutes_text \
                                         $duration_seconds_text \
                                         $duration_milliseconds_text)

    set -l separator_length (math $COLUMNS - '(' (string join + (string length $cmd_status $cmd_duration) 6) ')')
    set -l separator (string repeat -n $separator_length ─)

    set -l prompt_separator (set_color brblack)$separator(set_color normal)

    set -l status_color

    if [ $cmd_status -eq 0 ]
        set status_color green
    else
        set status_color $fish_color_error
    end

    set -l prompt_duration (set_color -b bryellow black)" $cmd_duration "(set_color normal)
    set -l prompt_status (set_color -b $status_color black)" $cmd_status "(set_color normal)
    set -l prompt_cwd (set_color $fish_color_cwd)(prompt_pwd)(set_color normal)
    set -l prompt_vcs (__fish_git_prompt)

    echo -ns $prompt_separator ' ' $prompt_duration ' ' $prompt_status \n $prompt_cwd $prompt_vcs ' $ '
end