# move a window to a different desktop
function move_window() {

    local window_title=$1
    local desktop_number=$2
    SEARCH_LOOP_LIMIT=600
    MOVE_LOOP_LIMIT=120

    # match the window title, partial match, caseless
    search_loop_counter=0
    window_list=""
    while [ ${#window_list} -eq 0 ] \
        && [ "$search_loop_counter" -le "$SEARCH_LOOP_LIMIT" ]
    do
        sleep 1
        window_list=$(wmctrl -l)
        window_list=$(
            awk -v title="$window_title" \
            'BEGIN {IGNORECASE=1} $0 ~ title { print $1 }' \
            <<< "$window_list")
        window_list=$( \
            grep '^[[:alnum:]]\+$' <<< "$window_list" \
        )
        ((search_loop_counter++))
    done

    # move the window
    while IFS= read -r window_id; do
        if [ ${#window_id} -gt 0 ] # this probably contradicts the while loop
        then
            current_desktop=-1
            loop_counter=0
            while [ "$desktop_number" -ne "$current_desktop" ] \
                && [ "$loop_counter" -le "$MOVE_LOOP_LIMIT" ]
            do
                sleep 1
                wmctrl -ir "$window_id" -t "$desktop_number"
                current_desktop=$(wmctrl -lG \
                    | awk -v id="$window_id" \
                    '$1 == id { print $2 }')
                ((loop_counter++))
            done
        fi
    done <<< "$window_list"

}