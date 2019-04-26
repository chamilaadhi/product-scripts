#!/bin/bash
access_token=$(sh access-token.sh)
echo "\nAccess token : " $access_token "\n"

################################get APIs ############################

payload=$(curl -k -H "Authorization: Bearer $access_token" -H "Content-Type: application/json" -X GET https://localhost:9443/api/am/publisher/v0.14/apis)
echo "\n"curl -k -H \"Authorization: Bearer $access_token\" -H \"Content-Type: application/json\" -X GET https://localhost:9443/api/am/publisher/v0.14/apis"\n"

echo "\n\nAPIs: \n\n" $payload "\n\n"