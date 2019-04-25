#!/bin/bash
access_token=$(sh access-token.sh)
echo "\nAccess token : " $access_token "\n"

create_and_publish_api() {
    local api_payload="$1"
    #echo "Waiting for completion"
    local api_id=$(curl -k -H "Authorization: Bearer $access_token" -H "Content-Type: application/json" -X POST -d @$api_payload.json https://localhost:9443/api/am/publisher/v0.14/apis | jq -r '.id')
    local publish_api_status=$(curl -k -H "Authorization: Bearer $access_token" -X POST "https://localhost:9443/api/am/publisher/v0.14/apis/change-lifecycle?apiId=${api_id}&action=Publish")
    sleep 5
    echo $api_id
}

#### Create two APIs######
echo "\n Creating Math API...\n"
math_api_id=$(create_and_publish_api "math")
echo $math_api_id
FILE=id.math_api_id
if test -f "$FILE"; then
    rm id.math_api_id
fi

echo $math_api_id >> id.math_api_id

echo "\n Creating Calculator API...\n"
calc_api_id=$(create_and_publish_api "calculator")
echo $calc_api_id

FILE=id.calc_api_id
if test -f "$FILE"; then
    rm id.calc_api_id
fi
echo $calc_api_id >> id.calc_api_id
#### Create two APIs done######