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
  "name": "APIProdudct1",
  "description": "Sample API Product 1"
}

EOF
}

echo "\n" curl -k -H \"Authorization: Bearer $access_token\" -H \"Content-Type: application/json\" -X POST -d \"$(api_product_payload)\" https://localhost:9443/api/am/publisher/v1.0/api-products
create_api_product() {
    local api_product_id=$(curl -k -H "Authorization: Bearer $access_token" -H "Content-Type: application/json" -X POST -d "$(api_product_payload)" https://localhost:9443/api/am/publisher/v1.0/api-products | jq -r '.id')
    echo $api_product_id
}
api_product_id=$(create_api_product)
FILE=id.productid.min
if test -f "$FILE"; then
    rm id.productid.min
fi

echo $api_product_id >> id.productid.min
echo " API Product: " $api_product_id