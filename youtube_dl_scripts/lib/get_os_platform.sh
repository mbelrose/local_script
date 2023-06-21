# test if platform is android termux or not
function is_android {
    if [[ "$(uname -o)" == 'Android' ]]
    then
        return 0
    else
        return 1
    fi
}