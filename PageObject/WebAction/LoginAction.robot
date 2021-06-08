#KW in page
*** Keywords ***
I am stay Login page
    wait until page contains  Sign in to your account  ${TIMEOUT}

I input email and password
   [Arguments]  ${email}  ${password}
    Input     ${EMAIL_FIELD}    ${email}
    Input     ${PASSWORD_FIELD}  ${password}

I click Sign In
    Click  ${SIGIN_BUTTON}
