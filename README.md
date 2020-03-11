# docker-mergerfs

Docker-mergerfs is a containerized version of mergerfs. It's simple, easy to use, and will soon have many additional features.

Roadmap: 

[*] Specify two or more directories to merge

[ ] Healthcheck to test against failed mounts

Example Usage (docker-compose):

```
version: "2"
services:

 mergerfs:
   image: docker-mergerfs
   container_name: mergerfs
   hostname: mergerfs
   cap_add:
     - SYS_ADMIN
   devices:
     - /dev/fuse
   restart: always
   volumes:
     - /root/test/folder1:/mnt/folder1
     - /root/test/folder2:/mnt/folder2
   environment: #all env variables required
     - MOUNTPOINT=vault
     - OPTIONS=async_read=false,use_ino,allow_other,func.getattr=newest,category.action=all,category.create=ff,cache.files=auto-full
     - SOURCEDIRS=/mnt/folder1:/mnt/folder2
     ```
