#!/bin/bash

function term_handler {
  kill -SIGTERM ${!}
  echo "sending SIGTERM to child pid"
  fuse_unmount
  echo "exiting now"
  exit $?
}

function fuse_unmount {
  fusermount -u -z /mnt/$MOUNTPOINT
}

makedir(){
	mkdir -p /mnt/$MOUNTPOINT
}

if [ -z "${SOURCEDIRS}" ]; then
  echo "No filesystems specified!"
fi

trap term_handler SIGINT SIGTERM

makdir
while true
do
  /usr/bin/mergerfs -f -o $OPTIONS "$SOURCEDIRS" /mnt/$MOUNTPOINT & wait ${!}
  echo "mergerfs crashed at: $(date +%Y.%m.%d-%T)"
  fuse_unmount
done

exit 144
