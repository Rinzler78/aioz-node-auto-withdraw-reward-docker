#!/bin/bash

## Re Run deploy
if ! deploy.sh
then
    echo "Deployment failed"
    exit 1
fi

while true; do
    withdraw.reward.sh
    sleep $CHECK_FREQ
done