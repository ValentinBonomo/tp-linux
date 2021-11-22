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

title=$(youtube-dl -e $1)
mkdir "$title"
cd /srv/yt/downloads/"$title"
youtube-dl -f mp4 -o "${title}.mp4" $1 &> /dev/null
youtube-dl --get-description $1 > description
#rm /srv/yt/downloads/"$title"/"$title".description

echo  Video $1 was downloaded.
echo  File path : /srv/yt/downloads/"$title"/"$title".mp4

echo  [$(date "+%D %T")] Video $1  was downloaded. File path : /srv/yt/downloads/"$title"/"$title".mp4 >> /var/log/yt/download.log
fi

