#!/bin/bash
access_token=$(sh access-token.sh)
echo "\nAccess token : " $access_token "\n"

FILE=$id.math_api_id
if test -f "$FILE"; then
    echo "######################  Run create-apis.sh script first ######################"
    exit
fi
math_api_id=$(cat id.math_api_id)
calc_api_id=$(cat id.calc_api_id)

################################CREATE API PRODUCT ############################
api_product_payload(){
    cat<<EOF
{
  "name": "CalculatorAPIProduct",
  "description": "A calculator API Product that supports basic operations",
  "thumbnailUri": "/api-products/01234567-0123-0123-0123-012345678901/thumbnail",
  "apiProductDefinition": "",
  "visibility": "PUBLIC",
  "visibleRoles": [],
  "visibleTenants": [
    "string"
  ],
  "state": "PUBLISHED",
  "subscriptionAvailability": "current_tenant",
  "subscriptionAvailableTenants": [
    "tenant1",
    "tenant2"
  ],
  "additionalProperties": {
    "additionalProp1": "string",
    "additionalProp2": "string",
    "additionalProp3": "string"
  },
  "businessInformation": {
    "businessOwner": "businessowner",
    "businessOwnerEmail": "businessowner@wso2.com"
  },
  "apis": [
    {
      "apiId": "$calc_api_id",
      "name": "CalculatorAPI",
      "resources": [
        "POST:/add",
        "POST:/divide"
      ]
    },
    {
      "apiId": "$math_api_id",
      "name": "MathAPI",
      "resources": [
        "GET:/area",
        "GET:/volume"
      ]
    }
  ]
}

EOF
}

create_api_product() {
    local api_product_id=$(curl -k -H "Authorization: Bearer $access_token" -H "Content-Type: application/json" -X POST -d "$(api_product_payload)" https://localhost:9443/api/am/publisher/v0.14/api-products | jq -r '.id')
    echo $api_product_id
}
api_product_id=$(create_api_product)
FILE=id.productid
if test -f "$FILE"; then
    rm id.productid
fi

echo $api_product_id >> id.productid
echo " API Product: " $api_product_id