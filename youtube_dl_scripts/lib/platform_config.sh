# set platform specific variables

function platform_config {
    if [[ "$(uname -o)" == 'Android' ]]
    then
        PLAYER_COMMAND='am start -n org.videolan.vlc/org.videolan.vlc.gui.video.VideoPlayerActivity -a android.intent.action.VIEW -d'
        HOME_DIR='/data/data/com.termux/files/home'
        cd "$HOME_DIR/storage/shared/Download"    
    else
        PLAYER_COMMAND='vlc'
        HOME_DIR=$HOME
        cd "/mnt/8cba077b-050c-47b9-9e82-8c8b0730ca1e/Videos/videos_to_move"
    fi
}
