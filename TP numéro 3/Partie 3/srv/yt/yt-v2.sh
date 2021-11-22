#!/bin/bash

if [ ! -d /srv/yt/downloads ]
then
mkdir downloads
    echo "Le fichier downloads n'éxistait pas je viens de le créer pour toi"
    exit
elif [ ! -d /var/log/yt ]; then
        echo "Le fichier de log n'es pas présent"
        exit 1
fi

if [[ ! -s /srv/yt/downloads/url.txt ]]
then
        echo "Please enter some url line by line in the file url.txt (path : /srv/yt/downloads/url.txt)"
	exit
fi
        cd /srv/yt/downloads
while [ -s url.txt ]
do
	head -n 1 url.txt >> alreadydownload.txt
	LIGNE1URL=$(head -n 1 url.txt)
	if [[ ! $LIGNE1URL =~ "https://www.youtube.com/watch" ]]; then
                sed -i '1d' /srv/yt/downloads/url.txt
                echo "Un des liens que tu as mis n'est pas un lien vers une vidéo Youtube"
		continue
        fi
        title=$(youtube-dl -e $LIGNE1URL)
        if [[ $title = "ERROR" ]]
        then
                echo there is a issue with the download
        	sed -i '1d' /srv/yt/downloads/url.txt
		continue
        fi
        mkdir /srv/yt/downloads/"$title"
        cd /srv/yt/downloads/"$title"
        sudo youtube-dl -f mp4 -o "${title}.mp4" "${LIGNE1URL}" &> /dev/null
	youtube-dl --get-description "${LIGNE1URL}" >> description
        echo  Video $LIGNE1URL was downloaded.
        echo  File path : /srv/yt/downloads/"$title"/"$title".mp4
	cd /srv/yt/downloads
	sed -i '1d' /srv/yt/downloads/url.txt
        echo  [$(date "+%D %T")] Video $LIGNE1URL  was downloaded. File path : /srv/yt/downloads/"$title"/"$title" >> /var/log/yt/download.log
done
