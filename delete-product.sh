#!/bin/bash
access_token=$(sh access-token.sh)
echo "\nAccess token : " $access_token "\n"

################################Delete API PRODUCT ############################
product_id=$(cat id.productid)
echo "Product Id : " $product_id

curl -k -v -H "Authorization: Bearer $access_token" -H "Content-Type: application/json" -X DELETE https://localhost:9443/api/am/publisher/v1.0/api-products/$product_id

echo "\n\nAPI Product: " $product_id " deleted.\n\n"