#!/bin/bash

if ! node.isInstalled.sh 
then
    echo "Node is not installed"
    exit 1
fi

reward=$(aioznode reward balance --endpoint "http://aioznode:1317")

echo "Reward balance json : $reward"

availableBalance=$(echo $reward | jq '.balance[0].amount' | sed 's/\"//g')
availableBalanceDenom=$(echo $reward | jq '.balance[0].denom' | sed 's/\"//g')

echo "Available balance to withdraw : $availableBalance $availableBalanceDenom"

if [[ "$availableBalance" != "null" && "$availableBalance" -gt $WITHDRAW_MIN_VALUE ]]; then
    echo "Try to withdraw... aioznode reward withdraw --endpoint "http://aioznode:1317" --address $WITHDRAW_ADDRESS_HEX --amount $availableBalance$availableBalanceDenom --priv-key-file $PRIV_KEY_FILE"
    aioznode reward withdraw --endpoint "http://aioznode:1317" --address $WITHDRAW_ADDRESS_HEX --amount $availableBalance$availableBalanceDenom --priv-key-file $PRIV_KEY_FILE
fi