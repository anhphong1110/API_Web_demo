*** Settings ***   
Resource    ../PageObject/Api/NotificationKW.robot
Suite Setup       Common-Api Get login token    notification
Suite Teardown          Delete All Sessions

*** Test Cases ***
1_API GET list notification response success with valid data 
    When Call API List notifications with valid data 
    Then Server response status "success" and code 200

2_API GET list notification response error when param per_page >100
    When Call API List notifications with per_page >100
    Then Server response status "error" , code 422 and message

3_API GET list notification unread response success and code 200 with valid data
    When Call API List notifications unread with valid data 
    Then Server response status "success" and code 200

4_API GET list notification unrea response error when param per_page >100  
    When Call API List notifications unread with per_page >100
    Then Server response status "error" , code 422 and message

5_API GET list notification ID response error when param notification ID does not exist
    When Call API List notifications ID with notification ID does not exist
    Then Server response status "error" , code 404 and message "The Notification with given id does not exist."

6_API GET list notification ID response error when param notification ID is not a valid uui
    When Call API List notifications ID with notification ID is not a valid uui
    Then Server response status "error" , code 422 and message "value is not a valid uuid"
    
7_API POST mark notification read response success with valid data
    When Call API mark notification read with valid notification id "7159ccfe-1169-43b6-82ac-1d7709d6cc7f"
    Then Server response status "success" and code 202
    And Notification Id is exist in response body    7159ccfe-1169-43b6-82ac-1d7709d6cc7f

8_API POST mark notification read response error when param ID is not a valid uui
    When Call API mark notification read with ID is not a valid uui
    Then Server response status "error" , code 422 and message "value is not a valid uuid"