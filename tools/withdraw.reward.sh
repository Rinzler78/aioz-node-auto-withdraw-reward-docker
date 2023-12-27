#!/bin/bash

if ! node.isInstalled.sh 
then
    echo "Node is not installed"
    exit 1
fi

reward=$(aioznode reward balance --endpoint "http://aioznode:1317")

# echo "Reward balance json : $reward"

# Retrieve storage earned
balance=$(echo $reward | jq '.balance[0].amount' | sed 's/\"//g')
balanceDenom=$(echo $reward | jq '.balance[0].denom' | sed 's/\"//g')

# Retrieve storage earned
storageEarned=$(echo $reward | jq '.storage_earned[0].amount' | sed 's/\"//g')
storageEarnedDenom=$(echo $reward | jq '.storage_earned[0].denom' | sed 's/\"//g')

# Retrieve storage earned
deliveryEarned=$(echo $reward | jq '.delivery_earned[0].amount' | sed 's/\"//g')
deliveryEarnedDenom=$(echo $reward | jq '.delivery_earned[0].denom' | sed 's/\"//g')

# Retrieve withdraw
withdraw=$(echo $reward | jq '.withdraw[0].amount' | sed 's/\"//g')
withdrawDenom=$(echo $reward | jq '.withdraw[0].denom' | sed 's/\"//g')

# Retrieve deliver count
deliveryCount=$(echo $reward | jq '.delivery_counter' | sed 's/\"//g')

echo "Balance : $balance $balanceDenom"
echo "Storage earned : $storageEarned $storageEarnedDenom"
echo "Delivery earned : $deliveryEarned $deliveryEarnedDenom"
echo "Withdraw : $withdraw $withdrawDenom"
echo "Delivery count : $deliveryCount $deliveryCountDenom"
echo ""

if [[ "$balance" != "null" && "$balance" -gt $WITHDRAW_MIN_VALUE ]]; then
    echo "Try to withdraw... aioznode reward withdraw --endpoint "http://aioznode:1317" --address $WITHDRAW_ADDRESS_HEX --amount $balance$balanceDenom --priv-key-file $PRIV_KEY_FILE"
    aioznode reward withdraw --endpoint "http://aioznode:1317" --address $WITHDRAW_ADDRESS_HEX --amount $balance$balanceDenom --priv-key-file $PRIV_KEY_FILE
fi