#!/bin/bash
username=admin
#to test with tenant, uncomment below
#username=admin@wso2.com
tokenUser=admin
appname=setup_apim_script_1
client_request() {
    cat <<EOF
{
    "callbackUrl": "wso2.org",
    "clientName": "$appname",
    "tokenScope": "Production",
    "owner": "$username",
    "grantType": "password refresh_token",
    "saasApp": true
}
EOF
}
client_credentials=$(curl -k -u $username:admin -H "Content-Type: application/json" -d "$(client_request)" https://localhost:9443/client-registration/v0.17/register| jq -r '.clientId + ":" + .clientSecret')
#echo $client_credentials
get_access_token() {
	echo "curl -k -d \"grant_type=password&username=$tokenUser&password=admin&scope=apim:api_workflow_view apim:api_workflow_approve apim:tenantInfo apim:admin_settings apim:api_view apim:api_publish apim:api_create apim:subscribe\" -u $client_credentials https://localhost:8243/token\n"
    local access_token=$(curl -k -d "grant_type=password&username=$tokenUser&password=admin&scope=apim:api_workflow_view apim:api_workflow_approve apim:tenantInfo apim:admin_settings apim:api_view apim:api_publish apim:api_create apim:subscribe" -u $client_credentials https://localhost:8243/token | jq -r '.access_token')
    echo $access_token
}

access_token=$(get_access_token)
echo $access_token
