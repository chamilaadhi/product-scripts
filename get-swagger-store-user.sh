#!/bin/bash
access_token=$(sh access-token.sh)
echo "\nAccess token : " $access_token "\n"

################################get swagger with login user ############################
product_id=$(cat id.productid)
echo "Product Id : " $product_id

echo "\n"curl -k -H \"Authorization: Bearer $access_token\" -X GET https://localhost:9443/api/am/store/v1.0/api-products/$product_id/swagger
payload=$(curl -k -H "Authorization: Bearer $access_token" -X GET https://localhost:9443/api/am/store/v1.0/api-products/$product_id/swagger)

echo "\n\nAPI Product swagger: \n\n" $payload "\n\n"