*** Settings ***                                                                                       
Library    Collections                                                                                 
Library    RequestsLibrary 
Resource    ../../Resource/GlobalVariables.robot

*** Keywords ***
Common-Api Get login token
    [Arguments]    ${session_name}
    Create Session  ${session_name}  ${global_url_api}
    &{headers_post}=    Create Dictionary    Accept=application/json    Content-Type=application/x-www-form-urlencoded
    ${data}=    Evaluate    str('grant_type=&username=${global_username}&password=${global_password}')
    ${resp}=    POST On Session     ${session_name}  /login   headers=${HEADERS_POST}   data=${data}  
    Status Should Be    200  ${resp}
    Set Suite Variable    ${token}    ${resp.json()['access_token']}
