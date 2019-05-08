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
api_product_id=$(cat id.productid)

echo "Updating API Product: "$api_product_id
################################CREATE API PRODUCT ############################
api_product_payload(){
    cat<<EOF
{
  "id" : "$api_product_id",
  "name": "CalculatorAPIProductName",
  "description": "A calculator API Product that supports basic operations. Updated description",
  "thumbnailUri": "/api-products/01234567-0123-0123-0123-012345678901/thumbnail",
  "visibility": "PRIVATE",
  "visibleRoles": ["testrole", "user1role"],
  "visibleTenants": [
    "wso2.com"
  ],
  "policies":["Unlimited", "Bronze"],
  "state": "PUBLISHED",
  "subscriptionAvailability": "all_tenants",
  "subscriptionAvailableTenants": [
    "test.com"
  ],
  "additionalProperties": {
    "additionalProp1": "string",
    "additionalProp2": "string",
    "additionalProp3": "string"
  },
  "businessInformation": {
    "businessOwner": "chamila",
    "businessOwnerEmail": "chamila@wso2.com"
  },
  "apis": [
    {
      "apiId": "$calc_api_id",
      "operations": [
        {
          "uritemplate": "/add",
          "httpVerb": "POST"
        },
        {
          "uritemplate": "/divide",
          "httpVerb": "POST"
        }
      ]
    },
    {
      "apiId": "$math_api_id",
      "operations": [
        {
          "uritemplate": "/area",
          "httpVerb": "GET"
        },
        {
          "uritemplate": "/volume",
          "httpVerb": "GET"
        }
      ]
    }
  ]
}

EOF
}

echo "\n"curl -k -H \"Authorization: Bearer $access_token\" -H \"Content-Type: application/json\" -X PUT -d \"$(api_product_payload)\" https://localhost:9443/api/am/publisher/v1.0/api-products/$api_product_id
create_api_product() {
    local api_product_id=$(curl -k -H "Authorization: Bearer $access_token" -H "Content-Type: application/json" -X PUT -d "$(api_product_payload)" https://localhost:9443/api/am/publisher/v1.0/api-products/$api_product_id)
    echo $api_product_id
}
update=$(curl -k -H "Authorization: Bearer $access_token" -H "Content-Type: application/json" -X PUT -d "$(api_product_payload)" https://localhost:9443/api/am/publisher/v1.0/api-products/$api_product_id)


echo " API Product Updated: " $update