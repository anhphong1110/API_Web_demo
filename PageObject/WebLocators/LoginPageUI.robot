#Web Locator
#I store own locators in robot file
*** Settings ***
Resource     ../../Resource/Variables.robot
*** Variables ***
${EMAIL_FIELD}          //input[@data-id='email']
${PASSWORD_FIELD}       //input[@data-id='password']
${SIGIN_BUTTON}         //button[@data-id='signIn']
${FORGOT_PASS_BTN}      //a[@class='login-form-forgot']
