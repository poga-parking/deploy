#!/bin/sh

SOURCE_PATH=~/poga-deploy

echo "Run logging stack..."
docker stack deploy -c $SOURCE_PATH/logging.yml --with-registry-auth logging
echo "Done!"
echo "Run monitoring stack..."
docker stack deploy -c $SOURCE_PATH/monitoring.yml --with-registry-auth monitoring
echo "Done!"