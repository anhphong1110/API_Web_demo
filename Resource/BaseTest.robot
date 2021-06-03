#Wrapper seleium api 
*** Settings ***
Library  SeleniumLibrary

*** Keywords ***
Common input to element
    [Arguments]  ${locator}  ${text}
     Wait Until Element Is Visible  ${locator}  ${TIMEOUT}
     clear element text  ${locator}
     sleep  150ms
     input text  ${locator}  ${text}

Common Text of element
    [Arguments]  ${locator}  ${text}
    wait until element is visible  ${locator}  ${TIMEOUT}
    element text should be  ${locator}  ${text}

Common Upload File
    [Arguments]  ${locator}  ${file_path}
    wait until page contains element  ${locator}  ${TIMEOUT}
    choose file  ${locator}  ${file_path}
