# move a window to a different desktop
function move_window() {

    local window_title=$1
    local desktop_number=$2

    # match the window title, partial match, caseless
    window_list=$(wmctrl -l)
    window_list=$(
        awk -v title="$window_title" \
        'BEGIN {IGNORECASE=1} $0 ~ title { print $1 }' \
        <<< "$window_list")
    window_list=$( \
        grep '^[[:alnum:]]\+$' <<< "$window_list" \
    )

    # move the window
    while read -r window_id; do
        if [ ${#window_id} -gt 0 ]
        then
            throttle=0
            while [[ $desktop_number -ne $current_desktop \
                && $throttle -le 60 ]]
            do
                sleep 1
                wmctrl -ir "$window_id" -t "$desktop_number"
                current_desktop=$(wmctrl -lG \
                    | awk -v id="$window_id" \
                    '$1 == id { print $2 }')
                ((throttle++))
            done
        fi
    done <<< "$window_list"

}