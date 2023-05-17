#!
for i in $(find links/url??); do
	echo '---'`date` >> output/$i.log
	~/bin/youtube-dl -x --user-agent \''Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.93 Safari/537.36'\' --referer 'https://www.youtube.com/' --no-progress -a $i >> output/$i.log 2>> output/$i.log 
done
