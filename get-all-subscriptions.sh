#!/bin/bash
access_token=$(sh access-token.sh)
echo "\nAccess token : " $access_token "\n"

################################get API PRODUCT ############################
#subscription_id=$(cat id.subscriptionId)
#echo "Subscription Id : " $subscription_id

payload=$(curl -k -v -H "Authorization: Bearer $access_token" -H "Content-Type: application/json" -X GET https://localhost:9443/api/am/store/v0.14/subscriptions)

echo "\n\nSubscription List: \n\n" $payload "\n\n"
