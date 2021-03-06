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

if [ -z "${SOURCEDIRS}" ]; then
  echo "No filesystems specified!"
fi

mkdir -p /mnt/$MOUNTPOINT
chmod 777 /mnt/$MOUNTPOINT

trap term_handler SIGINT SIGTERM

while true
do
  echo "mounting ${SOURCEDIRS}"
  /usr/bin/mergerfs -f -o $OPTIONS "$SOURCEDIRS" /mnt/$MOUNTPOINT & wait ${!}
  echo "mergerfs crashed at: $(date +%Y.%m.%d-%T)"
  fuse_unmount
done

exit 144
