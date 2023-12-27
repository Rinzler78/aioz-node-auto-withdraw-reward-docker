#!/bin/bash

# ## Re Run deploy
# if ! deploy.sh
# then
#     echo "Deploymentt failed"
#     exit 1
# fi

echo "Starting node for ${CHECK_FREQ}s..."

while true; do
    withdraw.reward.sh
    sleep $CHECK_FREQ
done