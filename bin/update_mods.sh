set -e

if [ -z $1 ]; then echo "Usage: `basename $0` servername [--test] [--skipdl]"; exit 1; fi

NAME=$1

BASEPATH=$HOME
if [ "$2" = "--test" ]; then BASEPATH=$HOME/test; fi
if [ "$2" = "--skipdl" ] || [ "$3" = "--skipdl" ]; then SKIPDOWNLOAD=yes; fi

MODIDS=$BASEPATH/files/modlists/${NAME}.txt
if [ ! -f $MODIDS ]; then echo "$MODIDS not found!"; exit 2; fi

STEAMDIR=$HOME/.steam/steamcmd
INSTALLDIR=$STEAMDIR/mods
ARMADIR=$BASEPATH/arma3
MODS=$ARMADIR/mods
UPDATEDKEYS=$ARMADIR/updated_keys
export AVAILABLEKEYS=$ARMADIR/available_keys/$NAME

function keys {
	key=$(basename "$1")
	if [ ! -f $AVAILABLEKEYS/$key ]; then
		ln -sv $1 $AVAILABLEKEYS/$key
	fi
}

export -f keys

ALLMODS=""
while read line; do
	ARRAY=($line)
	MOD=${ARRAY[0]}
	ALLMODS="$ALLMODS +workshop_download_item 107410 $MOD"
done < $MODIDS

echo "Updating mods"
if [ ! "$SKIPDOWNLOAD" = "yes" ]; then
	steamcmd +login zeusoperations +force_install_dir $INSTALLDIR $ALLMODS +quit
fi

echo
echo "Creating folders"
if [ ! -d $MODS/$NAME ]; then mkdir $MODS/$NAME; fi
if [ ! -d $UPDATEDKEYS/$NAME ]; then mkdir $UPDATEDKEYS/$NAME; fi

echo "Linking mods"
while read line; do
	ARRAY=($line)
	MODID=${ARRAY[0]}
	MODNAME=${ARRAY[1]}
	MODPATH=$MODS/$NAME/$MODNAME
	if [ -e $MODPATH ]; then
		rm $MODPATH
	fi
	ln -sv $INSTALLDIR/steamapps/workshop/content/107410/$MODID $MODPATH
	lowercase_single.sh $MODPATH
	find $MODPATH/ -type f -exec chmod -x {} \;
	find $MODPATH/ -iname "*.bikey" -exec bash -c 'keys "$0"' {} \;
	# ln -sv {} $UPDATEDKEYS/$NAME/ \;
done < $MODIDS
echo "Done"