if [ -z $NAME ]; then echo "Not to be run directly"; exit 1; fi

MODS="-mod="
MODS=${MODS}mods/@3cb_baf_equipment
MODS=${MODS}\;mods/@3cb_baf_units
MODS=${MODS}\;mods/@3cb_baf_vehicles
MODS=${MODS}\;mods/@3cb_baf_weapons
MODS=${MODS}\;mods/@advanced_rappelling
MODS=${MODS}\;mods/@advanced_slingloading
MODS=${MODS}\;mods/@cba_a3
MODS=${MODS}\;mods/@cup_terrain_core
MODS=${MODS}\;mods/@cup_terrain_cwa
MODS=${MODS}\;mods/@cup_terrain_maps
MODS=${MODS}\;mods/@fallujah
MODS=${MODS}\;mods/@ericj_taliban
MODS=${MODS}\;mods/@isla_abramia
MODS=${MODS}\;mods/@isla_duala
MODS=${MODS}\;mods/@island_panthera
MODS=${MODS}\;mods/@mrb_voicestop		# Voice stop for clients
MODS=${MODS}\;mods/@rhsafrf			# AFRF
MODS=${MODS}\;mods/@rhsgref			# GREF
MODS=${MODS}\;mods/@rhssaf			# SAF
MODS=${MODS}\;mods/@rhsusaf			# USAF
MODS=${MODS}\;mods/@task_force_radio
MODS=${MODS}\;mods/@vme_pla
MODS=${MODS}\;mods/@zeusops
MODS=${MODS}\;mods/@zeusops_napf

SERVERMODS="-serverMod="
#SERVERMODS=${SERVERMODS}mods/@ocap

#export MODS
