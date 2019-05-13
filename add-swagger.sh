#!/bin/bash
access_token=$(sh access-token.sh)
echo "\nAccess token : " $access_token "\n"

################################get API PRODUCT ############################
product_id=$(cat id.productid)
echo "Product Id : " $product_id

echo "\n"curl -k -H \"Authorization: Bearer $access_token\" -F apiDefinition=@openapi.json -X PUT https://localhost:9443/api/am/publisher/v1.0/api-products/$product_id/swagger
payload=$(curl -k -H "Authorization: Bearer $access_token" -F apiDefinition=@openapi.json -X PUT https://localhost:9443/api/am/publisher/v1.0/api-products/$product_id/swagger)
echo "\n\nAPI Product swagger: \n\n" $payload "\n\n"