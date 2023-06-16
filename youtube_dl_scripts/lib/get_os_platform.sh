# TODO: this might not work at all
function is_android {
    if [[ "$(uname -a)" =~ Android ]]
    then
        return 0
    else
        return 1
    fi
}