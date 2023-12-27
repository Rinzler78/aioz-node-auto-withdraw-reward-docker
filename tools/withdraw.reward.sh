#!/bin/bash

if ! node.isInstalled.sh 
then
    echo "Node is not installed"
    exit 1
fi

reward = $(aioznode reward withdraw)
availableBalance = $(echo $reward | jq '.balance[0].amount')
availableBalanceDenom = $(echo $reward | jq '.balance[0].denom')

echo "Available balance to withdraw : $availableBalance $availableBalanceDenom"

if &availableBalance > $WITHDRAW_MIN_VALUE
then
    echo "Try to withdraw..."
    aioznode reward withdraw --address $WITHDRAW_ADDRESS_HEX --amount $availableBalance$availableBalanceDenom --priv-key-file $PRIV_KEY_FILE
fi