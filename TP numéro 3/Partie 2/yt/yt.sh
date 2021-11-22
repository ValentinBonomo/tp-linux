#!/bin/bash

if [ ! -d /srv/yt/downloads ]
then
    mkdir downloads
    echo "Le fichier downloads n'éxistait pas je viens de le créer pour toi"
    exit
fi
if [ ! -d /var/log/yt ]; then
        echo "Le fichier de log n'es pas présent"
        exit 1
        else
if [[ $# -eq 0 ]]; then
        echo "Aucun url entré"
        exit 1
fi

cd /srv/yt/downloads

URL=$1
echo $URL > url.txt
LIGNE1URL=$(head -n 1 url.txt)

title=$(youtube-dl -e LIGNE1URL)
sudo youtube-dl -f mp4 -q --write-description -o '/srv/yt/downloads/%(title)s/%(title)s.%(ext)s' LIGNE1URL
sudo mv /srv/yt/downloads/"$title"/"$title".description /srv/yt/downloads/"$title"/description
#rm /srv/yt/downloads/"$title"/"$title".description
echo  Video LIGNE1URL was downloaded.
echo  File path : /srv/yt/downloads/"$title"/"$title".mp4

echo  [$(date "+%D %T")] Video LIGNE1URL  was downloaded. File path : /srv/yt/downloads/"$title"/"$title".mp4 >> /var/log/yt/download.log
fi

