*** Settings ***                                                                                       
Resource    ../Common/BaseAPI.robot                                                                                 


*** Keywords ***
Login token is get from api login
    Common-Api Get login token    notification

Call API List notifications with valid data 
    [Tags]  get
    &{headers_post}=    Create Dictionary    Accept=application/json    Authorization=Bearer ${token}
    ${params}=   Create Dictionary   search=test     sort=-id    page=1    per_page=100
    ${resp}=     GET On Session  notification  /notifications   params=${params}     headers=${HEADERS_POST}
    Set Test Variable    ${resp}

Call API List notifications with per_page >100
     [Tags]  get
    &{headers_post}=    Create Dictionary    Accept=application/json    Authorization=Bearer ${token}
    ${params}=   Create Dictionary   search=test     sort=-id    page=1    per_page=101
    ${resp}=  GET On Session  notification  /notifications   params=${params}     headers=${HEADERS_POST}    expected_status=422
    Set Test Variable    ${resp}


Call API List notifications unread with valid data 
    [Tags]  get
    &{headers_post}=    Create Dictionary    Accept=application/json    Authorization=Bearer ${token}
    ${params}=   Create Dictionary   search=test     sort=-id    page=1    per_page=100
    ${resp}=     GET On Session  notification  /notifications/unread   params=${params}     headers=${HEADERS_POST}
    Set Test Variable    ${resp}

Call API List notifications unread with per_page >100
     [Tags]  get
    &{headers_post}=    Create Dictionary    Accept=application/json    Authorization=Bearer ${token}
    ${params}=   Create Dictionary   search=test     sort=-id    page=1    per_page=101
    ${resp}=  GET On Session  notification  /notifications/unread   params=${params}     headers=${HEADERS_POST}    expected_status=422
    Set Test Variable    ${resp}

Call API List notifications ID with notification ID does not exist
     [Tags]  get
    &{headers_post}=    Create Dictionary    Accept=application/json    Authorization=Bearer ${token}
    ${notification_id}    Set Variable    82079cec-f5f2-430e-bdb8-0537e86616d0  
    ${resp}=  GET On Session  notification  /notifications/${notification_id}   headers=${HEADERS_POST}    expected_status=404
    Set Test Variable    ${resp}

Call API List notifications ID with notification ID is not a valid uui
     [Tags]  get
    &{headers_post}=    Create Dictionary    Accept=application/json    Authorization=Bearer ${token}
    ${notification_id}    Set Variable    test  
    ${resp}=  GET On Session  notification  /notifications/${notification_id}   headers=${HEADERS_POST}    expected_status=422
    Set Test Variable    ${resp}

Call API mark notification read with valid notification id "${id}"
     [Tags]  post 
    &{headers_post}=    Create Dictionary    Accept=application/json    Authorization=Bearer ${token}    Content-Type=application/json
    @{list_id}    Create List    ${id}    
    &{body_post}    Create Dictionary    ids=${list_id}   
    ${resp}=  POST On Session  notification  /notifications/read   headers=${HEADERS_POST}    json=${body_post}    
    Set Test Variable    ${resp}

Call API mark notification read with ID is not a valid uui
     [Tags]  post 
    &{headers_post}=    Create Dictionary    Accept=application/json    Authorization=Bearer ${token}    Content-Type=application/json    
    @{list_id}    Create List    test
    &{body_post}    Create Dictionary    ids=${list_id}   
    ${resp}=  POST On Session  notification  /notifications/read   headers=${HEADERS_POST}    json=${body_post}    expected_status=422
    Set Test Variable    ${resp}

Server response status "success" and code ${code}
    Should Be Equal As Strings  ${resp.status_code}        ${code}
    Should Be Equal As Strings  ${resp.json()['status']}  success

Server response status "error" , code ${code} and message
    Should Be Equal As Strings  ${resp.status_code}        ${code}
    Should Be Equal As Strings  ${resp.json()['results'][0]['msg']}  ensure this value is less than 101


Server response status "error" , code ${code} and message "${message}"
    Should Be Equal As Strings  ${resp.status_code}        ${code}
    Run Keyword And Return If    "${code}"=="404"    Should Be Equal As Strings  ${resp.json()['result']['msg']}  ${message}
    Run Keyword And Return If    "${code}"=="422"    Should Be Equal As Strings  ${resp.json()['results'][0]['msg']}  ${message}

Notification Id is exist in response body
    [Arguments]    ${id}
    Should Contain Any	${resp.json()['result']['ids']}	    ${id}
