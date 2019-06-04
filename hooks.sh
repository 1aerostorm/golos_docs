#!/bin/bash
set -e

case $1 in
        files-preextract)
                if [ -n "$UPDATE" ]; then
                    docker pull cyberway/cyberway:$BUILDTYPE
                    docker pull cyberway/cyberway-notifier:$BUILDTYPE
                    docker pull cyberway/golos.contracts:$BUILDTYPE
                    docker pull $CYBERWAY_IMAGE
                    docker pull $GOLOS_IMAGE
                fi
                ;;
        files-extracted)
		        sed -i 's/cyberway\/cyberway:latest/cyberway\/cyberway:$BUILDTYPE/' startup/docker-compose-events.yml
		        sed -i 's/cyberway\/cyberway-notifier:latest/cyberway\/cyberway-notifier:$BUILDTYPE/' startup/docker-compose-events.yml
                if [ -n "$UPDATE_GENESIS" ]; then
                    rm genesis-data -fR
                    mkdir genesis-data
                    env GOLOS_STATE=golos-state/genesis.dat GOLOS_IMAGE=$GOLOS_IMAGE DEST=genesis-data ./scripts/create-genesis.sh
                    rm  genesis-data/event-genesis/*
                    ln ee-genesis/* genesis-data/event-genesis/
                fi
                ;;

        nodeos-started)
                docker kill -s USR1 cyberway-notifier
                ;;

esac
exit 0
