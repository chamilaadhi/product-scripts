#!/bin/bash
#!/bin/bash
access_token=$(sh access-token.sh)
echo "\nAccess token : " $access_token "\n"

###############################################################################################################################

application_payload(){
    cat<<EOF
{
    "throttlingTier": "Unlimited",
    "description": "sample app description",
    "name": "sampleapp",
    "callbackUrl": "http://my.server.com/callback"
}
EOF
}


echo "\n"curl -k -H \"Authorization: Bearer $access_token\" -H \"Content-Type: application/json\" -X POST -d "'"$(application_payload)"'" https://localhost:9443/api/am/store/v0.14/applications "\n"
create_application() {
    local applicationId=$(curl -k -H "Authorization: Bearer $access_token" -H "Content-Type: application/json" -X POST -d "$(application_payload)" https://localhost:9443/api/am/store/v0.14/applications | jq -r '.applicationId')

    echo $applicationId
}
applicationId=$(create_application)
echo " Application Id: " $applicationId
productId=$(cat id.productid)

subscription_payload(){
  cat<<EOF
{
	    "tier": "Bronze",
			"apiProductIdentifier": "$productId",
		    "applicationId": "$applicationId"
}
EOF
}

echo "\n"curl -k -H \"Authorization: Bearer $access_token\" -H \"Content-Type: application/json\" -X POST -d "'"$(subscription_payload)"'" https://localhost:9443/api/am/store/v0.14/subscriptions"\n"
subscribe_to_product(){
     local subscriptionId=$(curl -v -k -H "Authorization: Bearer $access_token" -H "Content-Type: application/json" -X POST -d "$(subscription_payload)" https://localhost:9443/api/am/store/v0.14/subscriptions | jq -r '.subscriptionId')

    echo $subscriptionId   
}
subscriptionId=$(subscribe_to_product)
echo " Subscription Id: " $subscriptionId

FILE=id.subscriptionId
if test -f "$FILE"; then
    rm id.subscriptionId
fi
echo $subscriptionId >> id.subscriptionId

