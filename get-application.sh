#!/bin/bash
access_token=$(sh access-token.sh)
echo "\nAccess token : " $access_token "\n"

################################get API PRODUCT ############################


payload=$(curl -k -H "Authorization: Bearer $access_token" -H "Content-Type: application/json" -X GET https://localhost:9443/api/am/store/v0.14/applications)

echo "\n\nApplications : \n\n" $payload "\n\n"

echo "\n\n"curl -v -k -H \"Authorization: Bearer $access_token\" -H \"Content-Type: application/json\" -X DELETE https://localhost:9443/api/am/store/v0.14/applications