#!/bin/bash
#!/bin/bash
access_token=$(sh access-token.sh)
echo "\nAccess token : " $access_token "\n"

###############################################################################################################################

application_payload(){
    cat<<EOF
{
  "name": "CalculatorApp2",
  "throttlingTier": "Unlimited",
  "description": "Sample calculator application",
  "tokenType": "OAUTH"
}
EOF
}


echo "\n"curl -k -H \"Authorization: Bearer $access_token\" -H \"Content-Type: application/json\" -X POST -d "'"$(application_payload)"'" https://localhost:9443/api/am/store/v1.0/applications "\n"
create_application() {
    local applicationId=$(curl -k -H "Authorization: Bearer $access_token" -H "Content-Type: application/json" -X POST -d "$(application_payload)" https://localhost:9443/api/am/store/v1.0/applications | jq -r '.applicationId')

    echo $applicationId
}
applicationId=$(create_application)
echo " Application Id: " $applicationId
productId=$(cat id.productid)

subscription_payload(){
  cat<<EOF
{
	    "tier": "Bronze",
			"apiProductId": "$productId",
		    "applicationId": "$applicationId",
            "type" : "apiProduct"
}
EOF
}

echo "\n"curl -k -H \"Authorization: Bearer $access_token\" -H \"Content-Type: application/json\" -X POST -d "'"$(subscription_payload)"'" https://localhost:9443/api/am/store/v1.0/subscriptions"\n"
subscribe_to_product(){
     local subscriptionId=$(curl -v -k -H "Authorization: Bearer $access_token" -H "Content-Type: application/json" -X POST -d "$(subscription_payload)" https://localhost:9443/api/am/store/v1.0/subscriptions | jq -r '.subscriptionId')

    echo $subscriptionId   
}
subscriptionId=$(subscribe_to_product)
echo " Subscription Id: " $subscriptionId

FILE=id.subscriptionId
if test -f "$FILE"; then
    rm id.subscriptionId
fi
echo $subscriptionId >> id.subscriptionId

