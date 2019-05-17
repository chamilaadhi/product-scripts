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
  "visibility": "PUBLIC",
  "visibleRoles": ["testrole", "admin"],
  "visibleTenants": [
    "string"
  ],
  "policies":["Bronze","Silver","Unlimited"],
  "state": "PUBLISHED",
  "subscriptionAvailability": "specific_tenants",
  "subscriptionAvailableTenants": [
    "test.com"
  ],
  "additionalProperties": {
    "newprop": "string",
    "additionalProp2": "string",
    "additionalProp3": "string"
  },
  "scope" : "calculator",
  "businessInformation": {
    "businessOwner": "businessowner",
    "businessOwnerEmail": "businessowner@wso2.com"
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

echo "\n" curl -k -H \"Authorization: Bearer $access_token\" -H \"Content-Type: application/json\" -X POST -d \"$(api_product_payload)\" https://localhost:9443/api/am/publisher/v1.0/api-products
create_api_product() {
    local api_product_id=$(curl -k -H "Authorization: Bearer $access_token" -H "Content-Type: application/json" -X POST -d "$(api_product_payload)" https://localhost:9443/api/am/publisher/v1.0/api-products | jq -r '.id')
    echo $api_product_id
}
api_product_id=$(create_api_product)
FILE=id.productid
if test -f "$FILE"; then
    rm id.productid
fi

echo $api_product_id >> id.productid
echo " API Product: " $api_product_id