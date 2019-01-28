set -e

STEAMUSERNAME=zeusoperations

MODLISTS=$HOME/files/modlists
ALLMODIDS=/tmp/modids.txt
STEAMDIR=$HOME/.steam/steamcmd
INSTALLDIR=$STEAMDIR/mods
STEAMCMD=/usr/games/steamcmd
LOWERCASE=$HOME/files/bin/internal/lowercase_single.sh

sort $MODLISTS/* -u > $ALLMODIDS

ALLMODS=""
while read line; do
	ARRAY=($line)
	# File format:
	# @modname 123456
	MODID=${ARRAY[1]}
	if ! [ -z $MODID ]; then
		ALLMODS="$ALLMODS +workshop_download_item 107410 $MODID"
	else
		echo "Found empty modid"
	fi
done < $ALLMODIDS

echo $ALLMODS
echo $INSTALLDIR

echo "Updating mods"
$STEAMCMD +login $STEAMUSERNAME +force_install_dir $INSTALLDIR $ALLMODS +quit  | grep -v m_bIsFinalized

while read line; do
	ARRAY=($line)
	# File format:
	# @modname 123456
	MODID=${ARRAY[1]}
	$LOWERCASE $INSTALLDIR/steamapps/workshop/content/107410/$MODID
done < $ALLMODIDS

rm $ALLMODIDS
