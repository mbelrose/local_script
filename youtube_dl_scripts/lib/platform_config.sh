function platform_config {
    if is_android
    then
        PLAYER_COMMAND='am start -n org.videolan.vlc/org.videolan.vlc.gui.video.VideoPlayerActivity -a android.intent.action.VIEW -d'
        HOME_DIR='/data/data/com.termux/files/home'
        cd "$HOME_DIR/storage/shared/Download"
    else
        PLAYER_COMMAND='vlc'
        HOME_DIR='/media/mint/Local Disk/Users/user.DESKTOP-6UBKKRI'
        cd "$HOME_DIR/Videos/videos_to_move"
    fi
}