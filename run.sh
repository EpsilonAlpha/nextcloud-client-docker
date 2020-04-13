#!/bin/ash
# shellcheck shell=bash

# ensure, that the sync dir exists and is owned by the user
[ -d /media/nextcloud ] || mkdir -p /media/nextcloud
chown -R "$USER":"$GROUP" /media/nextcloud

[ -d /config ] || mkdir -p /config
chown -R "$USER":"$GROUP" /config

# chmod -R 777 /media/nextcloud	

file_exists() {
	if [ -e "$1" ]; then
		return 0
	fi
	return 1
}

# check exclude file exists
if file_exists "/config/exclude"; then
	EXCLUDE="--exclude /config/exclude"
fi

# check unsyncedfolders file exists
if file_exists "/config/unsyncedfolders"; then
	UNSYNCEDFOLDERS="--unsyncedfolders /config/unsyncedfolders"
fi

#construct command
CMD="/bin/su -s /bin/ash "$USER" -c 'nextcloudcmd "

if [ "$NC_HIDDEN" == true ]; then
	CMD="${CMD} -h"
fi
if [ "$NC_SILENT" == true ]; then
	CMD="${CMD} --silent"
fi
if [ "$NC_TRUST_CERT" == true ]; then
	CMD="${CMD} --trust"
fi

if [ -n "${EXCLUDE}" ]; then
	CMD="${CMD} ${EXCLUDE}"
fi
if [ -n "${UNSYNCEDFOLDERS}" ]; then
	CMD="${CMD} ${UNSYNCEDFOLDERS}"
fi
if [ -n "${NC_MAX_SYNC_RETRIES}" ]; then
	CMD="${CMD} --max-sync-retries ${NC_MAX_SYNC_RETRIES}"
fi

CMD="${CMD} --non-interactive -u $NC_USER -p $NC_PASS /media/nextcloud $NC_URL'"

while true
do

	eval "$CMD"
	#check if exit!
	if [ "$NC_EXIT" = true ] ; then
		
		if [  ! "$NC_SILENT" == true ] ; then 
			echo "NC_EXIT is true so exiting... bye!"
		fi
		
		exit;
	fi
	sleep "$NC_INTERVAL"
done
