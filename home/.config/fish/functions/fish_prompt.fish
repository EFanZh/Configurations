function fish_prompt --description 'Write out the prompt'
    set -l cmd_status $status
    set -l duration "0$CMD_DURATION"

    set -l duration_days (math "floor($duration / 86400000)")
    set -l duration_days_text

    if [ $duration_days -gt 0 ]
        set duration_days_text "$duration_days d"
    end

    set -l duration_hours (math "floor($duration / 3600000) % 24")
    set -l duration_hours_text

    if [ $duration_hours -gt 0 ]
        set duration_hours_text "$duration_hours h"
    end

    set -l duration_minutes (math "floor($duration / 60000) % 60")
    set -l duration_minutes_text

    if [ $duration_minutes -gt 0 ]
        set duration_minutes_text "$duration_minutes m"
    end

    set -l duration_seconds (math "floor($duration / 1000) % 60")
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

    set -l separator_length (math $COLUMNS - (string length "  $cmd_status   $cmd_duration "))
    set -l separator (string repeat -n $separator_length -N '-')

    set -l prompt_separator (set_color brblack)$separator(set_color normal)

    set -l status_color green

    if [ $cmd_status -ne 0 ]
        set status_color $fish_color_error
    end

    set -l prompt_duration (set_color -r bryellow)" $cmd_duration "(set_color normal)
    set -l prompt_status (set_color -r $status_color)" $cmd_status "(set_color normal)

    set -l virtualenv_prompt

    if set -q VIRTUAL_ENV
        set virtualenv_prompt '('(basename $VIRTUAL_ENV)') '
    end

    set -l prompt_cwd (set_color $fish_color_cwd)(prompt_pwd)(set_color normal)
    set -l prompt_vcs (fish_git_prompt)

    set -l prompt_suffix '$'

    echo -ns \
        \r $prompt_separator ' ' $prompt_duration ' ' $prompt_status \n \
        $virtualenv_prompt $prompt_cwd $prompt_vcs ' ' $prompt_suffix ' '
end
