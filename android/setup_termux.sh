# put openai key in ~/.keys/openai_api_key
# don't forget to install rlcone.conf and ssh keys if needed

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
pkg install man

pkg install python-lxml
pkg install libxslt
pip install streamlink
pkg install ffmpeg
pip install yt-dlp
# yt-dlp might require deno https://deno.com/
pkg install aichat

mkdir -p ~/.local/opt
cd ~/.local/opt
git clone https://github.com/mbelrose/local_script.git
cd local_script
source make_executable.sh
cd ~

#oh my zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
cp ~/.local/opt/local_script/oh_my_zsh_zshrc ~/.zshrc
pip install Pygments

# restart shell then run this for zsh-autosuggestions plugin
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
