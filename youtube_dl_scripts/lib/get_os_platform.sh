function is_desktop {
    if [[ "$(uname -a)" =~ Linux$ ]]
    then
    echo "desktop"
        true
    else
        false
    fi
}

function is_android {
    if [[ "$(uname -a)" =~ Android$ ]]
    then
        true
    else
        false
    fi
}