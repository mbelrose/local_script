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
        if [ ! -z "$window_id" ]
        then
            throttle=0
            while [[ "$desktop_number" != "$current_desktop" \
                && $throttle < 60 ]]
            do
                wmctrl -ir "$window_id" -t "$desktop_number"
                current_desktop=$(wmctrl -lG \
                    | awk -v id="$window_id" \
                    '$1 == id { print $2 }')
                throttle=$((throttle + 1))
            done
        fi
    done <<< "$window_list"

}