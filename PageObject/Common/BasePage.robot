#Common KWs are using all pages
*** Settings ***
Resource    BaseTest.robot

*** Keywords ***
Custom locator
    [Arguments]  ${string}  ${search_for}  ${replace}
    ${temp} =  replace string  ${string}  ${search_for}  ${replace}
    [Return]  ${temp}
    
Error message is displayed
    [Arguments]  ${message}
    
    wait until page contains  ${message}  ${TIMEOUT}

Successful message is displayed
    [Arguments]  ${message}
    wait until page contains  ${message}  ${TIMEOUT}

Message is not displayed
     [Arguments]  ${message}
    page should not contain  ${message}
 
