function set_directory {
    if is_android
    then
        HOME_DIR='/data/data/com.termux/files/home'
        cd "$HOME_DIR/storage/shared/Download"
    else
        HOME_DIR='/media/mint/Local Disk/Users/user.DESKTOP-6UBKKRI'
        cd "$HOME_DIR/Videos/videos_to_move"
    fi
}