# put openai key in ~/.keys/openai_api_key

pkg update
pkg upgrade
termux-setup-storage
pkg install termux-api
pkg install openssh
pkg install git
pkg install p7zip
pkg install zip
pkg install rclone
pkg install nodejs
pkg install python
pkg install zsh
pkg install libqrencode

pkg install libxslt
pip install streamlink
pkg install ffmpeg
pip install yt-dlp

cd ~/.local/opt
git clone https://github.com/mbelrose/local_script.git

#oh my zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
cp ~/.local/opt/local_script/oh_my_zsh_zshrc ~/.zshrc
pip install Pygments

# restart shell then run this for zsh-autosuggestions plugin
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
