export REPOSITORY=cyberway
export BUILDTYPE=latest

#export GOLOS_DB=mongodb://172.17.0.1:27017
#export GOLOS_DB=mongodb://readuser:12345@cyberway-mongodb.golos.io:27017/admin
#export CYBERWAY_DB=mongodb://golosd:12345-golosd-testner@172.17.0.1:27017/admin
#export SKIP_CONVERT_PUBLISH=1

#for file in accounts.dat funds.dat messages.dat pinblocks.dat transfers.dat; do
for file in messages.dat; do
    EXTRA_NODEOS_ARGS+=" --event-engine-genesis=/opt/cyberway/bin/genesis-data/event-genesis/$file"
done

