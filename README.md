BitTorrent Sync
===============

Sync uses peer-to-peer technology to provide fast, private file sharing for teams and individuals. By skipping the cloud, transfers can be significantly faster because files take the shortest path between devices. Sync does not store your information on servers in the cloud, avoiding cloud privacy concerns.

# Usage
$CONTAINER that will use the data volume
$SECRET the BTsync secret for that share
$FOLDER the folder name you want to use under /mnt/sync/folders

    docker run -d --name Sync \
      -p 55555 -p 55555/UDP \
	  -e "SYNC_DIR=/mnt/sync/folders/your_folder"
      --volume-from $CONTAINER \
      --restart on-failure \
      neilmillard/btsync $SECRET

# Volume

* /mnt/sync - State files and Sync folders

# Ports

* 8888 - Webui
* 55555 - Listening port for Sync traffic
